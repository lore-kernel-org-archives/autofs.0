From: "Douglas E. Engert" <deengert@anl.gov>
Subject: Re: Looking for a per user submount...
Date: Tue, 29 Jan 2008 08:27:09 -0600
Message-ID: <479F37BD.3050900@anl.gov>
References: <20080128101153.GE5803@mithrandir>
	<1201570926.3072.17.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1201570926.3072.17.camel@raven.themaw.net>
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



Ian Kent wrote:
> On Mon, 2008-01-28 at 11:11 +0100, Francesco P. Lovergine wrote:
>> I was looking for some sort of automounting for per-user subtrees.
>> Essentially I need to bind-mount on demand some per user (users are sql-based)
>> subdir like /path/<user>/mount_point, where /path/<user> is a true dir. 
>> I'm missing something or it cannot be performed using autofs without
>> adding each entry explicitly for every users ?

Have you looked at using an executable map? Something like in the master map:
/topdir   program:/etc/auto_per_user

/etc/auto_per_user:
#!/bin/sh
# $1 is <user>
echo ":/path/$1/mount_point"

> 
> Try something like.
> 
> In the master map:
> /topdir		/etc/auto.users
> 
> In auto.users:
> *	:/path/&
> 
> Clearly, the automount entries for future mounts aren't known until they
> are triggered, so they can't be seen no matter what options you use.
> 
> Ian
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
> 

-- 

  Douglas E. Engert  <DEEngert@anl.gov>
  Argonne National Laboratory
  9700 South Cass Avenue
  Argonne, Illinois  60439
  (630) 252-5444
