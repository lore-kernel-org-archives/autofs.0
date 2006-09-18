From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs mounts drives every 15 minutes
Date: Mon, 18 Sep 2006 10:55:19 -0400
Message-ID: <x4964fl8bs8.fsf@redhat.com>
References: <loom.20060918T154329-602@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <loom.20060918T154329-602@post.gmane.org> (jack snodgrass's
	message of "Mon, 18 Sep 2006 13:49:07 +0000 (UTC)")
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
To: jack snodgrass <mylinuxguy+autofs@gmail.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] autofs mounts drives every 15 minutes; jack snodgrass <mylinuxguy+autofs@gmail.com> adds:

mylinuxguy+autofs> I have autofs from Fedora FC5. ( autofs-4.1.4-29 ) when
mylinuxguy+autofs> my systems are mostly idel... autofs seems to want to
mylinuxguy+autofs> mount my drives every 15 minutes.

This is typically a hal problem.  Autofs only mounts file systems on
demand.  That is to say, autofs won't mount a file system until it is
accessed.  Try upgrading hal.

-Jeff
