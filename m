From: Mike Waychison <michael.waychison@sun.com>
Subject: Re: Passing the automounter mount options
Date: Fri, 03 Oct 2003 12:09:44 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F7D9F48.5000505@sun.com>
References: <Pine.LNX.4.44.0310031023200.17845-100000@fromage.scout.wisc.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Justin Rush <jrush@scout.wisc.edu>
Cc: autofs@linux.kernel.org

Justin Rush wrote:

>Hi,
>  I am troubleshooting nfs performance and I am trying to pass some 
>options to the automounter.  We are using NIS with an auto.home file to 
>automount user's homedirectories.  I have a line like :
>jrush -rw,soft,rsize=32768,wsize=32768,nfsvers=3 host:/path/to/home
>However it does not seem to work because I do not get the same perfermance 
>as when I do an nfs mount manually, ie. mount -t nfs host:/path dir/ -o 
>rsize=32768,wsize=32768,nfsvers=3
>  
>

Does /proc/mounts say that it is actually mounted with those options?

If not, then chances are the NIS map didn't get rebuilt.  Did you re-run 
'make' in /var/yp on the nis server?  If you are using NIS slaves, did 
you push the maps to them?

Mike Waychison
