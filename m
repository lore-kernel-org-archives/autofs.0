From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Question Regarding AutoFS and LDAP
Date: Thu, 24 May 2007 12:53:31 -0400
Message-ID: <x49odka40z8.fsf@segfault.boston.devel.redhat.com>
References: <001501c79e20$869f2ff0$f90110ac@SPCJVORIS1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <001501c79e20$869f2ff0$f90110ac@SPCJVORIS1> (Jacques VB Voris,
	IV's message of "Thu, 24 May 2007 12:28:11 -0400")
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
To: Jacques VB Voris IV <jvoris@screenpc.com>
Cc: autofs@linux.kernel.org

==> On Thu, 24 May 2007 12:28:11 -0400, "Jacques VB Voris IV" <jvoris@screenpc.com> said:

Jacques> Hello,
Jacques>     I am trying to using LDAP with AutoFS to mount a centralized home 
Jacques> directory structure on various nodes, and it isn't working. As far as I know 
Jacques> I have created all the objects in the LDAP directory correctly. But I get 
Jacques> the following message in the /var/log/messages file when I start AutoFS

Jacques>     lookup_init: lookup(ldap): failed to get query dn

Jacques>     I know this has been discuessed before, but I have not been able find 
Jacques> what the resolution was. I have AutoFS running on Fedora Core 6 with 
Jacques> OpenLDAP

Let's start with the basics:

What version of autofs?
grep "^automount" /etc/nsswitch.conf

get us your /etc/sysconfig/autofs file and /etc/auto.master

We may also need a debug log.  You can find information on how to
generate one on my people page:

  http://people.redhat.com/jmoyer

Look for the section entitled, "Filing bug reports."

Thanks!

Jeff
