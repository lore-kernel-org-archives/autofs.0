From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: mount fails because entry in multi-mount doesn't work
Date: Thu, 13 May 2004 15:05:31 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16547.50939.113325.98203@segfault.boston.redhat.com>
References: <40A38585.4050103@freescale.com>
	<Pine.LNX.4.58.0405132305230.13693@donald.themaw.net>
	<40A3BF4A.8080901@freescale.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40A3BF4A.8080901@freescale.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Tom Georgoulias <tom.georgoulias@freescale.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding Re: [autofs] mount fails because entry in multi-mount doesn't work; Tom Georgoulias <tom.georgoulias@freescale.com> adds:

tom.georgoulias> raven@themaw.net wrote:
>> Use the -nonstrict option on the autofs mount.

tom.georgoulias> Any docs for this?  I didn't see anything in the man pages
tom.georgoulias> about nostrict and I wasn't able to get it to work, so I
tom.georgoulias> want to be sure I've done everything correctly.

Spelling counts. ;)  nonstrict, not nostrict.  Give that a try.
                       ^
-Jeff
