From: Vincent McIntyre <vincent.mcintyre@csiro.au>
Subject: question about master map options
Date: Thu, 27 Mar 2014 17:34:57 +1100
Message-ID: <20140327063454.GH19822@mayhem.atnf.CSIRO.AU>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=email;
  t=1395902745; x=1427438745;
  h=date:from:to:subject:message-id:mime-version;
  bh=8S56HcmJAt0qXm3HCbhFHBS7MxL5bqKdWWkkuO35iWc=;
  b=VnZcxYPX4HJiL/J4CgQcR3+xqUGgARSmyN0AB4F5LzitkuYVsrtaBVE3
   OQq3oBJIuqpnRJ0L6y7gnqjKFSAMmsTRO/6aby3F+MOnogEoKM/YszXk0
   sUPKZlz6VhjayB4;
Content-Disposition: inline
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Hi,

in README.v5.release it says
- mount options present in the master map are now overridden by mount
  options in map entries instead of being accumulated. This behaviour
  is in line with other industry automount implementations.

but other places in the documentation refer to
mount options in the master map being appended
to those given to a specific map entry,
modulo the setting of APPEND_OPTIONS in /etc/defaults/autofs.

I can't figure it out from the code. Which way round is it, please?
I'd like to make the documentation consistent with itself
and the code.

Kind regards,
Vince
-- 
