From: Ian Kent <raven@themaw.net>
Subject: Re: autofs doesn't work anymore for me
Date: Sat, 15 Oct 2005 19:43:35 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0510151940360.2102@donald.themaw.net>
References: <Pine.GSO.4.58.0510121631440.19649@sun>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0510121631440.19649@sun>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Erik Mckee <emckee@cs.tamu.edu>
Cc: autofs@linux.kernel.org

On Wed, 12 Oct 2005, Erik Mckee wrote:

> Hello :)
> 
> I have both a gentoo box and a fedora core 4 box, neither of them will
> speak to my nfs server and automount.  Nothing shows up on my nfs server
> that it is even being contacted.  The nfs server is a SGI running IRIX64
> 6.5.  Automount gives me logs like the following:
> 
> Jun 19 20:01:23 bluefin automount[22097]: starting automounter version
> 4.1.3, path = /helm, maptype = file, mapname = /etc/autofs/auto_rooms
  ^^^^^ 
This doesn't look like an a Redhat packaged version?
If you use the tarball then use that latest version with the patches on 
kernel.org.

Ian
