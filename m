From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: autofs dont keep running in slackware
Date: Wed, 30 Jun 2004 10:56:33 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406301042440.7763@simba.math.ucla.edu>
References: <20040629204829.M71473@fabriciolima.com.br>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040629204829.M71473@fabriciolima.com.br>
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
To: Fabricio Lima <listas@fabriciolima.com.br>
Cc: autofs@linux.kernel.org

On Wed, 30 Jun 2004, Fabricio Lima wrote:
> autofs in redhat8 is working pretty good, but the automount using the 
> same /etc/auto.master and /etc/auto.misc at the slackware do not keep running 
> when I type 'ps ax'.

Try doing "ldd /usr/sbin/automount" to make sure that it's actually finding 
all its libraries.  That's a common reason for a program to exit 
immediately.  Also check in /proc/modules to see that the autofs module is 
really there.  Also, unload the module, then do "modprobe -v autofs", and 
see if there are any embarrassing error messages.

Someone else mentioned to try making /etc/mtab a symlink to /proc/mounts
because it's on a non-writeable filesystem.  This is good, but see the man
page of "mount" for a caveat involving loopback filesystems, e.g. crypto.  
"mount" writes things in /etc/mtab so umount can free the /dev/loop* device
automatically, but this doesn't happen if /etc/mtab -> /proc/mounts cannot
be written.

Actually, the writeable /etc/mtab in /etc is a crock.  I wonder if a 
symlink to /var/run/mtab or something like that would work.  

If you're trying to have a plethora of base distros, have a look at SuSE.  
I'm sure someone who runs Debian will have a similar suggestion.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
