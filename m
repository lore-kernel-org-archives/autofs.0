From: giggzounet <giggzounet@gmail.com>
Subject: Re: Automount /home for all the users when a user try to
	use /home
Date: Tue, 24 May 2011 08:32:04 +0200
Message-ID: <irfjd4$vc4$1@dough.gmane.org>
References: <ir2fpp$6q3$1@dough.gmane.org>
	<1306207386.3398.6.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1306207386.3398.6.camel@perseus.themaw.net>
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
To: autofs@linux.kernel.org

Le 24/05/2011 05:23, Ian Kent a =E9crit :
> On Thu, 2011-05-19 at 09:10 +0200, giggzounet wrote:
>> Hi,
>>
>> I'm using autofs for years and on different configurations. It works
>> great! so thx for your great work.
>>
>> But I have a little question/problem:
>> We have a cluster (with CentOS 5.5). It's a little cluster, so the /home
>> "is" on the master. And this /home is exported to the nodes. I have
>> installed autofs in order to automount this /home when a user wants to
>> use his /home.
>>
>> So at the moment the configuration is simple:
>> cat auto.master
>> /home   /etc/auto.home
>>
>> cat auto.home
>> *      nfs_oscar:/home/&
>>
>>
>> So when a user comes autofs mounts only the /home for the user.
>>
>> So at the moment it works. but I find it not optimal, because when 2
>> users try to connect from a node I get 2 mounts.
>>
>> I would like to get this behaviour:
>> when a user try to connect to his /home, autofs mount all the export
>> /home. It is possible ?
> =

> It might be possible to come up with a method to mount all the keys in a
> indirect map on first access but that sounds like it would be more
> difficult than it's worth.
> =

> Do you really need to mount these separately?
> =

> Could you use a direct mount map instead?
> You could do this by using the following:
> =

> in the master map (possibly /etc/auto.master):
> /-	/etc/auto.direct.homes
> =

> and /etc/auto.direct.homes could contain:
> /home	oscar:/home
> =

> This way there is only one mount not many and it will always make all
> home directories available on first access.
> =

> Ian

thx a lot! i will try this!
