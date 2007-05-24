From: "Jacques VB Voris IV" <jvoris@screenpc.com>
Subject: Question Regarding AutoFS and LDAP
Date: Thu, 24 May 2007 12:28:11 -0400
Message-ID: <001501c79e20$869f2ff0$f90110ac@SPCJVORIS1>
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
To: autofs@linux.kernel.org

Hello,
    I am trying to using LDAP with AutoFS to mount a centralized home 
directory structure on various nodes, and it isn't working. As far as I know 
I have created all the objects in the LDAP directory correctly. But I get 
the following message in the /var/log/messages file when I start AutoFS

    lookup_init: lookup(ldap): failed to get query dn

    I know this has been discuessed before, but I have not been able find 
what the resolution was. I have AutoFS running on Fedora Core 6 with 
OpenLDAP


Jacques VB Voris IV
ScreenPC

(E) jvoris@screenpc.com

This message and any accompanying attachments contains information from 
ScreenPC, Inc. that is confidential and/or privileged.  The information is 
intended to be for the use of the individual or entity named above. If you 
are not the intended recipient, be aware that any disclosure, copying, 
distribution or use of the contents of this information is prohibited. If 
you have received this email in error, please notify the sender immediately 
by reply email and destroy all copies of the original email. 
