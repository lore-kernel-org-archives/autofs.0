From: Vincent McIntyre <vincent.mcintyre@csiro.au>
Subject: expected behaviour for replicated servers
Date: Thu, 15 Jun 2017 12:19:49 +1000
Message-ID: <20170615021949.GM10434@mayhem.atnf.CSIRO.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1497493800; x=1529029800;
  h=date:from:to:subject:message-id:mime-version;
  bh=vFywW65k8kRwoVDUYHM2jc+RQXrWoysJdBOA9kCBGbk=;
  b=k9tMcb5HNgFMekTqCrG+rnWw+XvoZY03NbnzokCeASP8P0lgaJqjCu/S
   cqBr7ZIAORW+lkLPv3eiSk+6R9w/j+Hfa18kQyUMV3FuVSMmHFwyoCZdL
   kwq3VkDBNcETCpXGTFaJk1zm+G8xXI/iwUJqfqTZP17l2o6f7gUfQ06++
   8=;
Content-Disposition: inline
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Hello

I can't see this in the manpages or README.replicated-server,
perhaps I can provide a patch...

I have this setup:

$ grep autofs /etc/nsswitch.conf
autofs: files nis

$ cat /etc/auto.master
/nfs  auto.nfs  -rw,hard,intr,vers=3
$ ypcat -k auto.nfs
foo  -ro,hard  boxa,boxb:/export/foo


Question:

If boxa has the NFS server running (so autofs ping works)
but does not export /export/foo,
what is the expected behaviour?

boxa and boxb are in different subnets, the client is in
the same subnet as boxa.

What I am seeing is that the automount fails completely
upon trying boxa. boxb is never tried (no request logged on boxb).
Looking at the autofs debug log, I can see
get_nfs_info called for boxa, twice in fact.
For boxb, only get_supported_ver_and_cost is called,
after which the daemon tries to mount the share from boxa.


What I was hoping to see is that the client also tries boxb
before giving up.

I tried fiddling with:
 the order (boxb,boxa:/export/foo)
 weights (boxb(3),boxa:/export/foo),
but none of this made any difference.

This happens to be  5.0.8-2+deb8u1 but that's probably irrelevant.

Kind regards
Vince
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
