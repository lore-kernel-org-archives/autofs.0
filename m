From: Soyoung Park <Soyoung.Park@Sun.COM>
Subject: Re: Re: auto.net-like script for smbfs?
Date: Mon, 01 Dec 2003 13:52:19 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FCBB813.50101@sun.com>
References: <Pine.LNX.4.33.0312011405280.22187-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; format="flowed"; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Christoph Bugel <chris@tti-telecom.com>

Ian Kent wrote:

>On Mon, 28 Jan 2002, Christoph Bugel wrote:
>
>  
>
>>Is there a script that uses smbclient -L or something to
>>figure out the available shares on a given windows smb host,
>>similar to the auto.net script that uses showmount to figure
>>out the available mountpoints for a given NFS host?
>>    
>>
>
>No. Not yet.
>
>  
>
>>The goal is to have a /smb directory that will function just
>>like my NFS /net directory..
>>
>>currently I have auto.misc with the line
>>*  -fstype=smbfs,username=guest,password= ://&/c
>>But not all shares are called "C". I guess there is no
>>catch-all solution for the password thing, but maybe someone
>>has written the script for finding the shares?
>>    
>>
>
>No. I have never been able to satisfactorily use SMB shares in a 'real'
>domain environmnet. I have tried enough to not want do any more.
>
>  
>
i'm a little confused.

i've gotten smb mount to work w/ autofs, but not used any script.

what i did was:

1. create a share dir in my window machine for file share access
2. add an auto.smb file w/ line 
"-fstype=smbfs,username=username,password=password:\\path" and
3. motify auto.master to include auto.smb

and i was copying files across smb w/ the smb folder auto mounted.

the windows machine had to be password protected.

hope this helps.
