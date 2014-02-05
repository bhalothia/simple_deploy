module SimpleDeploy
  class AWS
    class InstanceReader
      def initialize
        @config = SimpleDeploy.config
        @logger = SimpleDeploy.logger
        @backoff_count = 0
        @attempts = 0
      end

      def list_stack_instances(stack_name)
        asg_id = auto_scaling_group_id(stack_name)
        return [] unless asg_id

        asg_instances = list_instances asg_id
        return [] unless asg_instances.any?

        describe_instances asg_instances
      end

      private

      def list_instances(asg_id)
        @backoff_count += 1
        @asg ||= Fog::AWS::AutoScaling.new :aws_access_key_id => @config.access_key,
                                           :aws_secret_access_key => @config.secret_key,
                                           :region => @config.region

        @attempts = 0
        begin
          body = @asg.describe_auto_scaling_groups('AutoScalingGroupNames' => [asg_id]).body
        rescue Exception => e
          if ((e.message == "Throttling => Rate exceeded") && (@attempts < 5)) 
            @logger.info "Throttling rate exceeded"
            SimpleDeploy::Backoff.exp_periods(@backoff_count < 5 ? @backoff_count : 5) do |backoff|
              @logger.info "Backing off for #{backoff} seconds. Attempt = #{@attempts}"
              sleep backoff
            end
            @attempts += 1
            @backoff_count += 1
            retry 
          end 
        end

        result = body['DescribeAutoScalingGroupsResult']['AutoScalingGroups'].last
        return [] unless result

        result['Instances'].map { |info| info['InstanceId'] }
      end

      def describe_instances(instances)
        @backoff_count += 1
        @ec2 ||= Fog::Compute::AWS.new :aws_access_key_id => @config.access_key,
                                       :aws_secret_access_key => @config.secret_key,
                                       :region => @config.region

        @attempts = 0
        begin
          @ec2.describe_instances('instance-state-name' => 'running',
                                  'instance-id' => instances).body['reservationSet']
        rescue Exception => e
          if ((e.message == "Throttling => Rate exceeded") && (@attempts < 5)) 
            @logger.info "Throttling rate exceeded"
            SimpleDeploy::Backoff.exp_periods(@backoff_count < 5 ? @backoff_count : 5) do |backoff|
              @logger.info "Backing off for #{backoff} seconds. Attempt = #{@attempts}"
              sleep backoff
            end
            @attempts += 1
            @backoff_count += 1
            retry
          end 
        end
      end

      def cloud_formation
        @cloud_formation ||= AWS::CloudFormation.new
      end

      def auto_scaling_group_id(stack_name)
        cf_stack_resources = cloud_formation.stack_resources stack_name
        parse_cf_stack_resources cf_stack_resources
      end

      def parse_cf_stack_resources(cf_stack_resources)
        asgs = cf_stack_resources.select do |r|
          r['ResourceType'] == 'AWS::AutoScaling::AutoScalingGroup'
        end
        asgs.any? ? asgs.first['PhysicalResourceId'] : false
      end

    end
  end
end
