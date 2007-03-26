From: jmoyer@redhat.com
Subject: Re: Unmount not working with 2.6.21  & 4.1.3/4.1.4
Date: Mon, 26 Mar 2007 12:58:17 -0400
Message-ID: <m3wt147xhy.fsf@redhat.com>
References: <9573979.6871174927016112.JavaMail.root@holcus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <9573979.6871174927016112.JavaMail.root@holcus> (Jarl
	Stefansson's message of "Mon, 26 Mar 2007 16:36:56 +0000 (GMT)")
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
To: Jarl Stefansson <jarl@marimo.is>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> Regarding Re: [autofs] Unmount not working with 2.6.21  & 4.1.3/4.1.4; Jarl Stefansson <jarl@marimo.is> adds:

jarl> Hi Ian, This is a brand new box so no.

jarl> The automount app is standard gentoo 4.1.3-R7, I also tried 4.1.4 but
jarl> I had issues getting it to run (with the same config as 4.1.3 it
jarl> simply would not start)

jarl> I googled for two days and verified that all known issues/race
jarl> conditions seem to be patched in 4.1.3-R7 so I'm at a loss as to what
jarl> the problem might be.

Are you sure that some application doesn't have an active reference to the
automounted file system?

-Jeff
