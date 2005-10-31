From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs4 looks up wrong path element when ghosting is enabled
Date: Mon, 31 Oct 2005 06:33:16 -0500
Message-ID: <17254.252.746357.935671@segfault.boston.redhat.com>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
	<17203.7543.949262.883138@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
	<17205.48192.180623.885538@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
	<17208.24786.729632.221157@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0510152006340.30122@donald.themaw.net>
	<17238.45372.628520.739194@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0510291536320.2949@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751082AbVJaLdl@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0510291536320.2949@donald.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org

==> Regarding Re: autofs4 looks up wrong path element when ghosting is enabled; Ian Kent <raven@themaw.net> adds:

raven> So to resolve this we need to ignore negative and unhashed dentries
raven> when checking if directory dentry is empty.
>>
raven> Please test this patch and let me know how you go.
>> OK, I've finally got 'round to testing your patch.  It does fix the test
>> case I was using.  My only concern is the potential for regressions.
>> I'll try making sure all of my various maps still work as advertised.

raven> I've spotted a regression with this patch.  It doesn't stop autofs
raven> from appearing to function correctly. It causes mount callbacks when
raven> they shouldn't made. So it seems that there is a case when an autofs
raven> directory is, as yet unhashed, but should be used.

I'm not sure I follow.  What do you mean it doesn't stop autofs from
*appearing* to function correctly?  Do you have a reproducer that fails?

-Jeff
