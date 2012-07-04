Feature: cloudfront-s3-invalidator without AWS credentials

  In order to invalidate my S3-based Cloudfront distribution
  As a geek without AWS credentials
  I want to run cf-s3-inv and see my that it tells me I have no valid credentials

  Scenario: Run cf-s3-inv with the configuration file that has invalid AWS access key
    Given a file named "_cf_s3_invalidator.yml" with:
    """
    s3_key: YOUR_AWS_S3_ACCESS_KEY_ID
    s3_secret: YOUR_AWS_S3_SECRET_ACCESS_KEY
    s3_bucket: your.bucket.com
    cloudfront_distribution_id: CF_ID
    """
    When I run `cf-s3-inv`
    And the output should contain:
    """
    The AWS Access Key Id you provided does not exist in our records. (AWS::S3::Errors::InvalidAccessKeyId)
    """

  Scenario: Run cf-s3-inv with CLI arguments containing invalid AWS access key
    When I run `cf-s3-inv --key invalid-aws-key --secret invalid-aws-secret --bucket some-bucket --distribution some-dist`
    And the output should contain:
    """
    The AWS Access Key Id you provided does not exist in our records. (AWS::S3::Errors::InvalidAccessKeyId)
    """