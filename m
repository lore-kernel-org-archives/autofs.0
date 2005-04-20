From: raven@themaw.net
Subject: RE: mount -o bind
Date: Wed, 20 Apr 2005 19:57:18 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504201949060.1883@donald.themaw.net>
References: <200504192203.j3JM3CJ32241@mail.velociti.us>
	<Pine.LNX.4.61.0504192158380.14524@xena.cft.ca.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0504192158380.14524@xena.cft.ca.us>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

On Tue, 19 Apr 2005, Jim Carter wrote:

>
> /ftp/* -bind /home/users/& /home/users/&/data

That would be something like

auto.master

/ftp	/etc/autofs.multi

and in autofs.multi

*	-bind	/users/&	:/home/users/&	\
 		/users/&/data	:/home/users/&/data

Which, on access (when ftp daemon changes to login directory) by, 
say user iank, should mount

/home/users/iank	on 	/ftp/users/iank
/home/users/iank/data	on	/ftp/users/iank/data

and after logout should umount both mounts on timeout.

the "*" wildcard key is replaced in the mount entry to form the mounts.
Only directories that are walked on should be mounted.

Ian
