From: "Ruslan U. Zakirov" <cubic@wildgate.miee.ru>
Subject: Re: making the mountpoints visible all the time
Date: Fri, 14 Nov 2003 21:54:31 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FB524E7.3090907@wildgate.miee.ru>
References: <Pine.LNX.4.33.0311141100050.30495-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0311141100050.30495-100000@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, "Taylor, ForrestX" <forrestx.taylor@intel.com>

Ian Kent wrote:

>On Thu, 13 Nov 2003, Taylor, ForrestX wrote:
>
>  
>
>>Alexander Macdonald wrote:
>>    
>>
>>>Hi
>>>
>>>I've currently got automount setup so that i can cd into a directory
>>>like /mnt/someplace and someplace will be automatically created and
>>>mounted... it would be quite usefull if that directory was allways
>>>visible so that i could browse to it in gui applications... how do i do
>>>that?
>>>      
>>>
>>If you want it visible all the time, use /etc/fstab, not autofs.  Work
>>is being done on leaving the directory structure before actually
>>mounting it, but it is not finished yet.
>>
>>    
>>
>
>Umm ...
>
>Beg to disagree.
>
>The autofs4-2.4 module build kit or the patches contained in it or the
>patches contained in autofs-4.1.0-beta3 can give you this for some of the
>maps. NIS, LDAP and file maps work at the moment.
>
>I's in the expected place on kernel.org.
>	
>  
>
        Hello, Ian and other.
As I've understand you've implemented readdir relaited syscalls in 
autofs for some map types, have you?

If so then I hope that soon we could see programm maps with such 
functionality.
I want to do progamm map wich allow something more native representation 
of windows workgroups like NetworkNigborhood. It would be very useful in 
plain networks(like our ~900 PC in one workgroup).

            Best regards. Ruslan.
