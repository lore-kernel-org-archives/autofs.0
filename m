From: Todd Denniston <Todd.Denniston@ssa.crane.navy.mil>
Subject: Re: making the mountpoints visible all the time
Date: Thu, 13 Nov 2003 19:53:40 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FB42794.F9EDED7A@ssa.crane.navy.mil>
References: <3FB3C4C4.4030605@yahoo.com> <3FB3E9B2.1090002@intel.com>
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
To: Alexander Macdonald <alexandermacdonald@yahoo.com>
Cc: autofs@linux.kernel.org

"Taylor, ForrestX" wrote:
> 
> Alexander Macdonald wrote:
> > Hi
> >
> > I've currently got automount setup so that i can cd into a directory
> > like /mnt/someplace and someplace will be automatically created and
> > mounted... it would be quite usefull if that directory was allways
> > visible so that i could browse to it in gui applications... how do i do
> > that?
> 
> If you want it visible all the time, use /etc/fstab, not autofs.  Work
> is being done on leaving the directory structure before actually
> mounting it, but it is not finished yet.
> 
> Forrest
Or you can fake it by having a directory where autofs puts its stuff and in the
directory where you want the mounts, have softlinks back to the correct autofs
location.

like autofs puts its stuff in 
/.autofs/mount1
and you do
ln -s /.autofs/mount1 /mnt/mount1

there are 2 problems I have seen with this (though I still use it)

1) if your home directory is in /mnt/mount1 you (if PS1=\h:\w\$ on bash) will
see "machine:/.autofs/mount1$ " until you type cd once.

2) if you do an ls in /mnt/ (or navigate a netscape/openoffice.org [save/open]
through it) you will be waiting until autofs has processed mounting all the
autofs mounts.


-- 
Todd Denniston
Crane Division, Naval Surface Warfare Center (NSWC Crane) 
Harnessing the Power of Technology for the Warfighter
