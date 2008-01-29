From: Ian Kent <raven@themaw.net>
Subject: Re: Looking for a per user submount...
Date: Tue, 29 Jan 2008 10:42:06 +0900
Message-ID: <1201570926.3072.17.camel@raven.themaw.net>
References: <20080128101153.GE5803@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080128101153.GE5803@mithrandir>
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
To: "Francesco P. Lovergine" <f.lovergine@ba.issia.cnr.it>
Cc: autofs@linux.kernel.org


On Mon, 2008-01-28 at 11:11 +0100, Francesco P. Lovergine wrote:
> I was looking for some sort of automounting for per-user subtrees.
> Essentially I need to bind-mount on demand some per user (users are sql-based)
> subdir like /path/<user>/mount_point, where /path/<user> is a true dir. 
> I'm missing something or it cannot be performed using autofs without
> adding each entry explicitly for every users ?

Try something like.

In the master map:
/topdir		/etc/auto.users

In auto.users:
*	:/path/&

Clearly, the automount entries for future mounts aren't known until they
are triggered, so they can't be seen no matter what options you use.

Ian
