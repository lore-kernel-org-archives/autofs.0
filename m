From: Ian Kent <raven@themaw.net>
Subject: Re: dead lock (autofs and/or mount)
Date: Sat, 04 Nov 2006 09:50:51 +0800
Message-ID: <1162605051.25017.12.camel@localhost>
References: <454B7750.9000307@infomaniak.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <454B7750.9000307@infomaniak.ch>
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
To: cedric briner <work@infomaniak.ch>
Cc: autofs <autofs@linux.kernel.org>

On Fri, 2006-11-03 at 18:07 +0100, cedric briner wrote:
> sarge
> autofs-4.1.3
> mount-2.12p
> uname -r : 2.6.8-3-686
> 
> hello,
> I'm having such difficulties between the mount and the autofs package.
> When autofs want to mount a resource which is not available, i get into 
> this situation:
> 
> in my situation a nested mount in unavailable!
> 
> # ps -efH
> 
> root      4588     1  0 Oct25 ?        00:00:00   /usr/sbin/automount
> --pid-file=/var/run/autofs/_home_photom.pid --timeout=300 --ghost
> /home/photom yp auto_home_photom
> 
> root     21442  4588  0 13:41 ?        00:00:00     /usr/sbin/automount
> --pid-file=/var/run/autofs/_home_photom.pid --timeout=300 --ghost
> /home/photom yp auto_home_photom
> 
> root     21444 21442  0 13:41 ?        00:00:00       [mount] <defunct>
> 
> root     21450     1  0 13:41 ?        00:00:00   mount --
> obssb13:/export/diskA2/backup/carrier
> 
> # ypcat -k auto_home_photom | grep carrier
> carrier -bg / obssb6:/export/diskA1/& /unsaved obssb6:/export/diskA2/&
>   /backup obssb13:/export/diskA2/backup/&

Don't use -bg.

How can autofs mount all entries of a multi-mount, with potential
nesting, if a mount operation is put into background. When a mount
operation is put into the background mount returns success which may not
actually true.

This is a sure way to break multi-mounts such as you are using here.

Ian
