From: Ian Kent <raven@themaw.net>
Subject: Re: Automount /home for all the users when a user try to
 use /home
Date: Tue, 24 May 2011 11:23:06 +0800
Message-ID: <1306207386.3398.6.camel@perseus.themaw.net>
References: <ir2fpp$6q3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=Eef5pIIIOdNCo9sK9+2BJUaYRdI=;
	b=XjZp/t2JcQVFkOIxbB/3kC147yzNbRsUWhJytKlr5+yzLkWYiWe+aqvOzkaGdxMJmdYGBCuFTvuKvjEDf+UwPZQvcB2hECnH5jt1Q7Z5NnhkMWrlB1fEEJ6Bm23YPCjmSnbCNqhFYQTg2FxW+w14g5UY2ZSo01cokXvG1aO/CXU=
In-Reply-To: <ir2fpp$6q3$1@dough.gmane.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: giggzounet <giggzounet@gmail.com>
Cc: autofs@linux.kernel.org

On Thu, 2011-05-19 at 09:10 +0200, giggzounet wrote:
> Hi,
> 
> I'm using autofs for years and on different configurations. It works
> great! so thx for your great work.
> 
> But I have a little question/problem:
> We have a cluster (with CentOS 5.5). It's a little cluster, so the /home
> "is" on the master. And this /home is exported to the nodes. I have
> installed autofs in order to automount this /home when a user wants to
> use his /home.
> 
> So at the moment the configuration is simple:
> cat auto.master
> /home   /etc/auto.home
> 
> cat auto.home
> *      nfs_oscar:/home/&
> 
> 
> So when a user comes autofs mounts only the /home for the user.
> 
> So at the moment it works. but I find it not optimal, because when 2
> users try to connect from a node I get 2 mounts.
> 
> I would like to get this behaviour:
> when a user try to connect to his /home, autofs mount all the export
> /home. It is possible ?

It might be possible to come up with a method to mount all the keys in a
indirect map on first access but that sounds like it would be more
difficult than it's worth.

Do you really need to mount these separately?

Could you use a direct mount map instead?
You could do this by using the following:

in the master map (possibly /etc/auto.master):
/-	/etc/auto.direct.homes

and /etc/auto.direct.homes could contain:
/home	oscar:/home

This way there is only one mount not many and it will always make all
home directories available on first access.

Ian
