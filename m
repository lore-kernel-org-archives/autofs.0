From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Tue, 15 Feb 2005 09:33:51 -0500
Message-ID: <16914.2127.559335.703678@segfault.boston.redhat.com>
References: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
	<20050215014857.GA26216@uio.no>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050215014857.GA26216@uio.no>
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
Content-Type: text/plain; charset="us-ascii"
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] [ANNOUNCE] autofs 4.1.4 beta2 release; "Steinar H. Gunderson" <sgunderson@bigfoot.com> adds:

sgunderson> On Mon, Feb 14, 2005 at 10:39:51PM +0800, raven@themaw.net
sgunderson> wrote:
>> Here is autofs 4.1.4 beta2.

sgunderson> Thanks! :-)

sgunderson> I've gone through all the Debian patches again, and this needs
sgunderson> looking into:

sgunderson> 035_program_mount_repeated_last_character_of_map_output is in
sgunderson> there, but there looks like there's an identical situation
sgunderson> further down. Could you investigate? (I'm not really sure if it
sgunderson> is an error or not, to be honest, I just want it checked. :-) )

Yes, looks like a problem to me.  Thanks!  Attached is a patch.

-Jeff

--- autofs-4.1.4_beta2/modules/lookup_program.c.program-map-stderr-extra-char	2005-02-15 09:30:46.672165592 -0500
+++ autofs-4.1.4_beta2/modules/lookup_program.c	2005-02-15 09:31:23.840515144 -0500
@@ -237,6 +237,7 @@ int lookup_mount(const char *root, const
 			if (read(epipefd[0], &ch, 1) < 1) {
 				FD_CLR(epipefd[0], &ourfds);
 				files_left--;
+				state = st_done;
 			} else if (ch == '\n') {
 				*errp = '\0';
 				if (errbuf[0])
