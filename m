From: Mikel Jimenez <mikel@irontec.com>
Subject: Re: Fwd: Re:  autofs+LDAP
Date: Tue, 23 Sep 2008 09:08:02 +0200
Message-ID: <48D895D2.7020502@irontec.com>
References: <ab2c1458ef71935d134b68a0b988d9bb@irontec.com>
	<1222135728.8564.62.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1222135728.8564.62.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent escribi=F3:
> On Mon, 2008-09-22 at 20:15 +0200, mikel wrote:
>   =

>> -------- Original Message --------
>> Subject: Re: [autofs] autofs+LDAP
>> Date: Mon, 22 Sep 2008 20:14:21 +0200
>> From: mikel <mikel@irontec.com>
>> To: "Douglas E. Engert" <deengert@anl.gov>
>>
>> mmm very interesting... that is what I need!!
>>
>> I want to have the capability to personalize automount for each user.
>>
>> I want user1 have in /home mass_storage_ip:/remote_homes/user1
>>
>> and user2:  /home mass_storage_ip:/remote_homes/user2
>>     =

>
> You really don't want to do it this way exactly do you?
>
> Surely you mean you want the mounts to be:
> user1: /home/user1   mass_storage_ip:/remote_homes/user1
> user2: /home/user2   mass_storage_ip:/remote_homes/user2
>
>   =

>> Guide to do that...
>> A lot of thanks!! really
>>
>> On Mon, 22 Sep 2008 11:33:40 -0500, "Douglas E. Engert" <deengert@anl.go=
v>
>> wrote:
>>     =

>>> Ian Kent wrote:
>>>       =

>>>> On Sun, 2008-09-21 at 23:40 +0200, Mikel Jimenez wrote:
>>>>         =

>>>>> Hello Guys
>>>>>
>>>>> I have a OpenLDAP server with user accounts. Actually, i autheticate =
my
>>>>> LAN machines to LDAP server and ALL OK.
>>>>>
>>>>> I want that:
>>>>>
>>>>> EXAMPLE:
>>>>> day 1:
>>>>> user1 login in machine1 and I want to mount via NFS, the home of this
>>>>> user, that is in another storage server
>>>>>
>>>>> day 2: user 1 login in machine6 and I want to mount via NFS, the home
>>>>>           =

>>> of
>>>       =

>>>>> this user, that is in another storage server
>>>>>
>>>>>
>>>>> I want to have all users homes, in a centralized storage server, and
>>>>> give the posibility to users to login in any machine of the LAN, and
>>>>> have they home directory mounted automaticaly.
>>>>>
>>>>> Is that posible with autofs+LDAP?
>>>>>           =

>>> In auto.master, you can have an entry like:
>>> /home ldap:nisMapName=3Dauto_XXXXX,ou=3DAutofs,....
>>> and have each system specify a different auto_XXXXX location in LDAP to
>>> start from.
>>>
>>> Or you could have have script in place of the auto.home entry:
>>> /home auto_select_script,....
>>> where auto_select_script is a script that is passed the username.
>>> It can use ldap to determine what to do.
>>>
>>>       =

>>>> Basically yes, but there are a number of decisions about how this might
>>>> be setup at your site that don't relate specifically to autofs.
>>>>
>>>> Ian
>>>>
>>>>
>>>> _______________________________________________
>>>> autofs mailing list
>>>> autofs@linux.kernel.org
>>>> http://linux.kernel.org/mailman/listinfo/autofs
>>>>
>>>>
>>>>         =

>>> --
>>>
>>>   Douglas E. Engert  <DEEngert@anl.gov>
>>>   Argonne National Laboratory
>>>   9700 South Cass Avenue
>>>   Argonne, Illinois  60439
>>>   (630) 252-5444
>>>       =

>> _______________________________________________
>> autofs mailing list
>> autofs@linux.kernel.org
>> http://linux.kernel.org/mailman/listinfo/autofs
>>     =

>
>   =

YES YES!!

That is it!!
