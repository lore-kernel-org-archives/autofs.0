From: Ian Kent <raven@themaw.net>
Subject: Re: sshfs and target directory
Date: Wed, 23 Dec 2009 22:35:06 +0800
Message-ID: <4B322A9A.5010706@themaw.net>
References: <1261522601-sup-5290@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1261522601-sup-5290@nixos>
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
To: Marc Weber <marco-oweber@gmx.de>
Cc: autofs <autofs@linux.kernel.org>

Marc Weber wrote:
> summary:
> 
> sshfs mounting user@host: works but user@host:/ does not.
> 
> I had to apply this patch:
> 
> diff --git a/modules/parse_sun.c b/modules/parse_sun.c
> index 65417e1..35d9edc 100644
> --- a/modules/parse_sun.c
> +++ b/modules/parse_sun.c
> @@ -827,7 +827,7 @@ static int validate_location(char *loc)
>  			    *ptr == '-' || *ptr == '.' || *ptr == '_' ||
>  			    *ptr == ',' || *ptr == '(' || *ptr == ')' ||
>  			    *ptr == '#' || *ptr == '@' || *ptr == ':' ||
> -			    *ptr == '[' || *ptr == ']'))
> +			    *ptr == '[' || *ptr == ']' || *ptr == '/' ))
>  				return 0;
>  			ptr++;
>  		}
> 
> 
> 
> in order to make  this work which doesn't mount /root but /
> 
> rootlap   -fstype=fuse,rw,nodev,nonempty,noatime,max_read=65536,uid=1008,gid=100 \/nix\/store\/yfmbrb7d7hh9n6dyidypw7k1xcixxmmz-sshfs-wrapped\/bin/\sshfs-wrapped\#root@host\:\/
> 
> I'm not sure whether this is the perfect patch.
> 
> Probably the problem is that the trailing :/ triggers check_colon to
> return 1 in validate_location which is then failing in the loop I
> patched above because "/" was not a valid character.

Yes, this has come up recently and it's a bit painful.

If *ptr is a "/" then that is not valid in this case so we can do that.

But if you add a ":" escape to the beginning of the mount location this
check will not be made. I can't remember the sshfs syntax but something
like :sshfs#<user>@<host: should work OK.

Ian


> 
> Marc Weber
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
