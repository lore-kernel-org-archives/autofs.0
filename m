From: Ian Kent <raven@themaw.net>
Subject: Re: autofs+LDAP
Date: Mon, 22 Sep 2008 12:35:10 +0800
Message-ID: <1222058110.3163.78.camel@raven.themaw.net>
References: <48D6BF37.1050404@irontec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48D6BF37.1050404@irontec.com>
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
To: Mikel Jimenez <mikel@irontec.com>
Cc: autofs@linux.kernel.org

On Sun, 2008-09-21 at 23:40 +0200, Mikel Jimenez wrote:
> Hello Guys
> 
> I have a OpenLDAP server with user accounts. Actually, i autheticate my 
> LAN machines to LDAP server and ALL OK.
> 
> I want that:
> 
> EXAMPLE:
> day 1:
> user1 login in machine1 and I want to mount via NFS, the home of this 
> user, that is in another storage server
> 
> day 2: user 1 login in machine6 and I want to mount via NFS, the home of 
> this user, that is in another storage server
> 
> 
> I want to have all users homes, in a centralized storage server, and 
> give the posibility to users to login in any machine of the LAN, and 
> have they home directory mounted automaticaly.
> 
> Is that posible with autofs+LDAP?

Basically yes, but there are a number of decisions about how this might
be setup at your site that don't relate specifically to autofs.

Ian
