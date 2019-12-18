
output "nlb-targetgrp-arn" {
  value = "${aws_lb_target_group.simplr-nlb-tg.arn}"
}


# export nlb-targetgrp-arn=`terraform output nlb-targetgrp-arn`