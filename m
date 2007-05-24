From: "Jacques VB Voris IV" <jvoris@screenpc.com>
Subject: Re: Question Regarding AutoFS and LDAP
Date: Thu, 24 May 2007 13:09:01 -0400
Message-ID: <002d01c79e26$3b456d20$f90110ac@SPCJVORIS1>
References: <001501c79e20$869f2ff0$f90110ac@SPCJVORIS1>
	<x49odka40z8.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Jeff,
    Thank you for your prompt response. I was able to figure out what I was 
doing wrong after taking another look at the /etc/sysconfig/autofs.


Jacques VB Voris IV
ScreenPC
101 Merritt 7
5th Floor
Norwalk, CT 96851

(E) jvoris@screenpc.com
(P) 203-842-0460 x606

This message and any accompanying attachments contains information from 
ScreenPC, Inc. that is confidential and/or privileged.  The information is 
intended to be for the use of the individual or entity named above. If you 
are not the intended recipient, be aware that any disclosure, copying, 
distribution or use of the contents of this information is prohibited. If 
you have received this email in error, please notify the sender immediately 
by reply email and destroy all copies of the original email.
----- Original Message ----- 
From: "Jeff Moyer" <jmoyer@redhat.com>
To: "Jacques VB Voris IV" <jvoris@screenpc.com>
Cc: <autofs@linux.kernel.org>
Sent: Thursday, May 24, 2007 12:53 PM
Subject: Re: [autofs] Question Regarding AutoFS and LDAP


> ==> On Thu, 24 May 2007 12:28:11 -0400, "Jacques VB Voris IV" 
> <jvoris@screenpc.com> said:
>
> Jacques> Hello,
> Jacques>     I am trying to using LDAP with AutoFS to mount a centralized 
> home
> Jacques> directory structure on various nodes, and it isn't working. As 
> far as I know
> Jacques> I have created all the objects in the LDAP directory correctly. 
> But I get
> Jacques> the following message in the /var/log/messages file when I start 
> AutoFS
>
> Jacques>     lookup_init: lookup(ldap): failed to get query dn
>
> Jacques>     I know this has been discuessed before, but I have not been 
> able find
> Jacques> what the resolution was. I have AutoFS running on Fedora Core 6 
> with
> Jacques> OpenLDAP
>
> Let's start with the basics:
>
> What version of autofs?
> grep "^automount" /etc/nsswitch.conf
>
> get us your /etc/sysconfig/autofs file and /etc/auto.master
>
> We may also need a debug log.  You can find information on how to
> generate one on my people page:
>
>  http://people.redhat.com/jmoyer
>
> Look for the section entitled, "Filing bug reports."
>
> Thanks!
>
> Jeff
>
> 
