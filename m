From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs doesn't look at second LDAP server
Date: Tue, 07 Oct 2008 13:00:49 +0800
Message-ID: <1223355649.3031.18.camel@raven.themaw.net>
References: <BAC1D28A5AB852439A6914CA7AB4E63F05192E66@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAC1D28A5AB852439A6914CA7AB4E63F05192E66@permls05.wde.woodside.com.au>
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
To: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Cc: autofs@linux.kernel.org

On Wed, 2008-07-16 at 09:20 +0800, Coe, Colin C. (Unix Engineer) wrote:
> Hi all
> 
> I've noticed that, after a period of stability, autofs is dumping core
> again.
> 
> The common thread is the time the core dumping happens, 4AM (give or
> take a few minutes) which is when our 'cron daily' process runs.  This
> 'cron daily' lives on an NFS mount that is in the auto_global map
> ('/nfs/appl server:/vol/oldserver_appl').
> 
> Looking through the logs I see that autofs couldn't talk to the ldap
> server.  We have two ldap servers in case one isn't available.  Looks
> like autofs isn't trying the second ldap server, is this a known issue?
> 

snip ...

> Jul 13 04:03:01 las006 automount[31280]: parse_ldap_config:
> lookup(ldap): user: (null), secret: unspecified, client principal:
> (null) credential cache: (null)
> Jul 13 04:03:01 las006 automount[31280]: parse_ldap_config:
> lookup(ldap): user: (null), secret: unspecified, client principal:
> (null) credential cache: (null)
> Jul 13 04:03:01 las006 automount[31280]: find_server: trying server
> ldaps://aether.woodside.com.au:636
> Jul 13 04:03:01 las006 automount[31280]: find_server: trying server
> ldaps://aether.woodside.com.au:636

Looking at this again, this doesn't necessarily mean autofs isn't
looking at additional configured servers as each map mount will have its
own context with a copy of the servers and should independently try each
of the servers. This log fragment only indicates that each map is trying
the first server in its list.

Ian
