From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 + sshfs works but autofs5 + sshfs fails
Date: Mon, 11 Jun 2007 12:40:18 +0800
Message-ID: <1181536818.3423.13.camel@shark.themaw.net>
References: <2345.69.243.87.84.1181344860.squirrel@webmail.cis.jhu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <2345.69.243.87.84.1181344860.squirrel@webmail.cis.jhu.edu>
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
To: akolasny@cis.jhu.edu
Cc: autofs@linux.kernel.org

On Fri, 2007-06-08 at 19:21 -0400, akolasny@cis.jhu.edu wrote:
> Greetings:
> 
> My NIS auto.net has an entry that looks similar to:
> 
>    my_dir -fstype=fuse,reconnect,allow_other,uid=6000,gid=6000,umask=0002
> sshfs#user@some.site:/my_dir
> 
> It works fine with CentOS 4 x86, x86_64 and ia64 distributions using autofs4. I
> installed CentOS 5 x86_64
> which uses autofs5 and this NIS mount failed.
> 
> Note: In order to allow NIS to properly provide the auto.net entry, I needed to
> make a minor change to
>       the /var/yp/Makefile to allow '#' in the NIS database.
> 
> The 'automount -v -d' reports in /var/messages something like:
> 
>    Jun  8 19:02:23 c1 automount[27076]: attempting to mount entry /net/my_dir
>    Jun  8 19:02:24 c1 automount[27076]: parse_mount: parse(sun): invalid location
>    Jun  8 19:02:24 c1 automount[27076]: failed to mount /net/my_dir
> 
> 
> Does autofs-5.0.1/modules/parse_sun.c 'validate_location' function need to allow
> the '#' to
> get this working again? If it's something simple like this, would it be possible
> to add to
> the next release?

The location validation is fairly strict in what it thinks should be a
host name. I'll have a look.

Ian
