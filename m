From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Large number of mount request.
Date: Fri, 07 Jul 2006 10:40:37 -0400
Message-ID: <x49lkr51nru.fsf@segfault.boston.redhat.com>
References: <20060623112741.95825.qmail@web34505.mail.mud.yahoo.com>
	<007601c6a0af$aea99c70$251a17ac@ZyXEL.com>
	<1152187091.8761.6.camel@raven.themaw.net>
	<00b201c6a17a$8050d160$251a17ac@ZyXEL.com>
	<Pine.LNX.4.64.0607071653410.2893@raven.themaw.net>
	<00ec01c6a1be$34af4e00$251a17ac@ZyXEL.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <00ec01c6a1be$34af4e00$251a17ac@ZyXEL.com> (Latrell's message
	of "Fri, 7 Jul 2006 20:09:21 +0800")
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Latrell <is85022@cis.nctu.edu.tw>
Cc: autofs@linux.kernel.org, ramana@intraperson.com, Ian Kent <raven@themaw.net>

==> Regarding Re: [autofs] Large number of mount request.; "Latrell" <is85022@cis.nctu.edu.tw> adds:

is85022> Sorry for misunderstanding what you mean. I think I should describe my
is85022> scenario in detail.
is85022> I use autofs to mount shares under user's home directory. It functions
is85022> normally in normal cases.
is85022> However, in stress test,  the user continuously login->change directory
is85022> (autofs mount in this time) -> logout (a SIGERM sent to the automount
is85022> daemon) --> login.......

Why is a SIGTERM sent to automount when you logout?  It shouldn't be.

-Jeff
