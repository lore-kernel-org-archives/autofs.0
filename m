From: Ladd Hebert <lhebert@hou.asp.ti.com>
Subject: Re: Passing the automounter mount options
Date: Fri, 3 Oct 2003 11:28:35 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20031003162835.GA5006@hou.asp.ti.com>
References: <Pine.LNX.4.44.0310031023200.17845-100000@fromage.scout.wisc.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310031023200.17845-100000@fromage.scout.wisc.edu>
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
To: Justin Rush <jrush@scout.wisc.edu>
Cc: autofs@linux.kernel.org

On Fri, Oct 03, 2003 at 10:28:37AM -0500, thus Justin Rush spoke:
> Hi,
>   I am troubleshooting nfs performance and I am trying to pass some 
> options to the automounter.  We are using NIS with an auto.home file to 
> automount user's homedirectories.  I have a line like :
> jrush -rw,soft,rsize=32768,wsize=32768,nfsvers=3 host:/path/to/home
> However it does not seem to work because I do not get the same perfermance 
> as when I do an nfs mount manually, ie. mount -t nfs host:/path dir/ -o 
> rsize=32768,wsize=32768,nfsvers=3
> 
> Am I missing something here or just editing the wrong file?
> 
---end quoted text---

You didn't specify which OS/Distro, but on my Redhat machines, I edit the
/etc/init.d/autofs init script directly. There is a section in the init
script that allows you to specify mount options and daemon options.

Ie:
#
# We can add local options here
# e.g. localoptions='rsize=8192,wsize=8192'
#
localoptions=''

# Daemon options
# e.g. --timeout 60
#
daemonoptions=''


-Ladd

-- 
+----------------------------------+
| Ladd J Hebert <lhebert/@\ti.com> |
| UNIX Systems Administrator       |
| Stafford Infrastructure Team     |
| Texas Instruments - Stafford,TX  |
| "visualize world blinker usage"  |
+----------------------------------+
