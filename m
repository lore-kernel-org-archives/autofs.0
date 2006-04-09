From: Ian Kent <raven@themaw.net>
Subject: Re: cross automount issue
Date: Sun, 9 Apr 2006 12:19:40 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0604091218001.3969@eagle.themaw.net>
References: <Pine.LNX.4.64.0604062047510.13380@q7.q7.com>
	<Pine.LNX.4.58.0604072342530.24984@wombat.indigo.net.au>
	<Pine.LNX.4.64.0604070923300.15746@q7.q7.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0604070923300.15746@q7.q7.com>
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
To: Joe Pruett <joey@clean.q7.com>
Cc: autofs@linux.kernel.org

On Fri, 7 Apr 2006, Joe Pruett wrote:

> after sending it, i started wondering what the lock was there for.  i wasn't
> sure if each automount daemon was multi-threaded or not.  what mount locking
> are you referring to?

The lock was introduced to prevent corruption of /etc/mtab because the 
locking in mount for this purpose didn't work.

There are patches for mount which I believe fix it.

Ian
