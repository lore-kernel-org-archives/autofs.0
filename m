From: Justin Rush <jrush@scout.wisc.edu>
Subject: Re: Passing the automounter mount options
Date: Fri, 3 Oct 2003 13:13:57 -0500 (CDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0310031310220.23288-100000@fromage.scout.wisc.edu>
References: <20031003162835.GA5006@hou.asp.ti.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20031003162835.GA5006@hou.asp.ti.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladd Hebert <lhebert@hou.asp.ti.com>
Cc: autofs@linux.kernel.org

Thanks to everyone for their input,
  I did try to originally put it in the auto.home file, and yes I did 
remake the NIS files and push them out.
  When that didn't work, I tried editing the autofs init script, however 
this seemed not to work either.
localoptions='rsize=32768,wsize=32768,nfsvers=3'
is the line that I used.
I am running redhat 9 with all the updated rpms.

Is there anything else that I missing?
Again, any responses are greatly appreciated.

On Fri, 3 Oct 2003, Ladd Hebert wrote:

> On Fri, Oct 03, 2003 at 10:28:37AM -0500, thus Justin Rush spoke:
> > Hi,
> >   I am troubleshooting nfs performance and I am trying to pass some 
> > options to the automounter.  We are using NIS with an auto.home file to 
> > automount user's homedirectories.  I have a line like :
> > jrush -rw,soft,rsize=32768,wsize=32768,nfsvers=3 host:/path/to/home
> > However it does not seem to work because I do not get the same perfermance 
> > as when I do an nfs mount manually, ie. mount -t nfs host:/path dir/ -o 
> > rsize=32768,wsize=32768,nfsvers=3
> > 
> > Am I missing something here or just editing the wrong file?
> > 
> ---end quoted text---
> 
> You didn't specify which OS/Distro, but on my Redhat machines, I edit the
> /etc/init.d/autofs init script directly. There is a section in the init
> script that allows you to specify mount options and daemon options.
> 
> Ie:
> #
> # We can add local options here
> # e.g. localoptions='rsize=8192,wsize=8192'
> #
> localoptions=''
> 
> # Daemon options
> # e.g. --timeout 60
> #
> daemonoptions=''
> 
> 
> -Ladd
> 
> 

-- 
Justin Rush
Technical Specialist
Internet Scout Project
jrush@scout.wisc.edu
