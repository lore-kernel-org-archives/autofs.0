From: Ian Kent <raven@themaw.net>
Subject: Re: backfstype parameter supported.
Date: Wed, 30 Jun 2004 07:50:33 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406300748090.32407@wombat.indigo.net.au>
References: <40E1632D.1080903@deragon.biz>
	<Pine.LNX.4.58.0406292140380.14746@donald.themaw.net>
	<40E17F4F.6060307@deragon.biz>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40E17F4F.6060307@deragon.biz>
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
To: Hans Deragon <hans@deragon.biz>
Cc: autofs@linux.kernel.org

On Tue, 29 Jun 2004, Hans Deragon wrote:

> > Those messages are difficult to eliminate as they often come from 
> > mount(8) itself.
> 
> In cachefs case, we know that Linux does not support it.  Should we simply catch 
> it and immediately try the backfstype?  This would avoid the errors.
> 
> Is automount used on any OS where cachefs is supported?  Anyhow, I could 
> implement a #ifdef LINUX statement which will catch cachefs only for Linux OS. 
> Anybody knows of an actual macro I could use to figure out if the kernel is Linux?

autofs is a Linux automounter so we need to worry about clashes, like 
this, with centralised map stores shared by other OSs.

Ian
