From: Greg Bradner <gregb@rhythm.com>
Subject: running out of mount points
Date: Mon, 19 Jan 2004 07:48:53 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <400BFC65.3000700@rhythm.com>
References: <Pine.LNX.4.33.0401130932460.10047-100000@wombat.indigo.net.au>
	<4004409C.6040900@sun.com> <Pine.LNX.4.58.0401142351470.1783@raven.themaw.net>
	<40059944.4060901@rhythm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40059944.4060901@rhythm.com>
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
To: autofs@linux.kernel.org

I wanted to repost this plea. I am really in a bind and could use some 
help. I need to mount these users on the mail server.
BTW: this is with autofs 4.1.0


Greg Bradner wrote:

> I have run into a problem of running out of mount points.  I have over 
> 600 users and their home dirs are listed in auto.home and they are all 
> stored on the same nfs server.  If I list the dirs, automount will 
> create a seperate mount point for each user, and at ~256 mount points, 
> no more home dirs can be mounted.
> Is there a work around?
>
> Here is the auto.master and snip of auto.home
>
>
> auto.master:
> /home                   /etc/auto.maps/auto.home
>        vers=3,hard,intr,nosuid,nodev,rw,retrans=4,timeo=15,mountvers=2
>
>
> auto.home:
> gregb ntap:/vol/vol0/u/&
>
>
