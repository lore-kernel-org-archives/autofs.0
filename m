From: Oren Held <oren@held.org.il>
Subject: auto.net patch
Date: Sun, 12 Oct 2003 02:49:38 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1065919778.3576.22.camel@localhost>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello,

Debian already added this patch to the deb package, but I think it'd
better be modified in the official release.

What it does is forces the 'sort' command to sort stuff as the default
behavior and not use the locale-specific LC_COLLATE which changes the
default sort behavior.
(man sort, look for the *** WARNING ***.. that's what they suggest). 

(I DID experienced a problem caused by a weird sort behavior, if you
wondered..)

Theoretically LC_COLLATE=C could be enough, but LC_ALL=C will do no harm
(that's also what the Debian package maintainer did)..

What do you say? Any reason why NOT to apply this patch?

- Oren
