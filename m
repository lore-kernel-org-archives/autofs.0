From: Daniel Lutz <danlutz@debian.org>
Subject: Re: Debian: Init script confused by options
Date: Wed, 12 May 2004 11:29:07 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040512092907.GB28873@majestix.home.watz.ch>
References: <16541.33862.63334.177007@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <16541.33862.63334.177007@Psilocybe.Update.UU.SE>
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
Content-Transfer-Encoding: 7bit
To: Thorild Selen <thorild@Update.UU.SE>
Cc: autofs@linux.kernel.org

> Starting the automounter in Debian:
> 
> > [Psilocybe] update # /etc/init.d/autofs start
> > Starting automounter: --ghost.

[...]

The init script used by the official Debian package isn't yet
included in the upstream sources, i. e. the Debian-specific
parts of the init script contained in the upstream sources
is out of date. The init script of the official Debian package
is currently generated from the init script contianed in the
upstream sources by applying a lot of patches.

I recommend you to take the init script from the latest official
Debian package. 

Correct creation of pid files should also work with this script.

-Daniel
