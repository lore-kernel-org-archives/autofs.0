From: Prakash Velayutham <prakash.velayutham@cchmc.org>
Subject: Re: autofs-4.1.3 not working properly
Date: Mon, 28 Nov 2005 09:22:28 -0500
Message-ID: <438B12A4.1040106@cchmc.org>
References: <s388370e.056@n6mcgw16.cchmc.org>
	<Pine.LNX.4.63.0511271725001.2406@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511271725001.2406@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> On Sat, 26 Nov 2005, Prakash Velayutham wrote:
>
>   
>>>>> Ian Kent <raven@themaw.net> 11/25/05 1:47 PM >>>
>>>>>           
>> On Thu, 24 Nov 2005, Prakash Velayutham wrote:
>>
>>     
>>> Hi,
>>>
>>> I am new to this list, so please forgive my ignorances.
>>> I had a SuSE Pro 9.0 system running autofs (v3) running earlier. The 
>>> autofs itself did not have any issues at all until I decided to
>>>       
>> upgrade 
>>     
>>> the system to SuSE 9.3. It was a clean install, and autofs4-4.1.3
>>>       
>> became 
>>     
>>> the default kernel autofs module. My autofs master map comes from a 
>>> OpenLDAP server and it contains 3 different mount maps.
>>> /users (LDAP map)
>>> /protein/users (LDAP map)
>>> /import/users (LDAP map)
>>> I also have a file-based map in this server (/export/users).
>>>
>>> Recently I was trying to move a user's home dir from server1 to
>>>       
>> server2. 
>>     
>>> After moving his home dir and making the relevant changes to his LDAP 
>>> entry (homeDirectory attribute), I tried to restart autofs in the 
>>> above-mentioned server. The server already had several users logged in
>>>       
>>> under /protein/users. Though the restart did not complain, I noticed 
>>> that autofs status showed "Configured mount points" correctly and 
>>> removed the currently mounted mount points from "Active mount points".
>>>       
>>> Is there a reason why? Also strangely the ownerships of the previously
>>>       
>>> mounted dirs had been changed to root:root.
>>>       
>> I'm not sure what is not working or what has been broken.
>> What is the actual problem and symptom?
>>
>> Ian
>>
>> Thanks Ian for a reply. What if I restart autofs when a user whose home
>> dir is mounted through autofs is already logged into the system (and
>> hence at least one of the automount entries is being used)? What will
>> the system do in that case?
>>     
>
> On runing "reload" it should, depending on version and patch levels 
> re-read and update the map, leave the mounted directory mounted and leave 
> the stale map entry for cleanup next time the map is reloaded and the 
> entry isn't mounted. 
>
> "Restart"ing is much more agressive and I wouldn't recommend it if you 
> have mount that are in use. To restart you really need to have nothing 
> actually in use.
>
>   
>> And also if I change the ldap attribute "homeDirectory" for a user, do I
>> have to restart autofs in a system for that change to be seen. Because I
>> sometimes see that the system has cached the user's attributes from LDAP
>> and tries to use that and fails.
>>     
>
> autofs doesn't use that attribute so no, but you'll need to be sure that 
> the automount map entry that is used to access that directory is still 
> valid following the change and if it also had to be changed then you might 
> need to "reload" autofs. It's worth pointing out that later versions (most 
> RedHat versions and 4.1.4 I think) of autofs should recognise this change 
> on access without needing to re-load the map.
>
> The other thing I noticed about your query was the question about the root 
> owned directory. At variuos times in the past development autofs has been 
> (mostly intentionally) lazy about cleaning up mount point directories. 
> When autofs directories don't have a filesystem mounted on them they will 
> appear root owned. It shouldn't make a difference to operation.
>
> Ian
Thanks Ian. I tried out autofs reload and there seems to be a small 
glitch. It says "checking for changes in auto.master" and then stops 
some of the automount daemons. But stays there forever. If I do Ctrl-C, 
then it immediately shows "Starting XXX" for the different automount 
daemons (except 1 for some reason). Is there a reason for this 
behaviour. The system I am trying out is SuSE Linux 10.0, autofs-4.1.4-6 
with automount master map and the entries coming from a OpenLDAP server.

Thanks,
Prakash
