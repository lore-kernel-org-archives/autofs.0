From: Ian Kent <raven@themaw.net>
Subject: Re: unable to automount windows C$
Date: Tue, 02 Jun 2009 19:17:58 +0800
Message-ID: <4A250A66.4070206@themaw.net>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A59F5.1090308@edcint.co.nz> <4A0A5B80.4040303@themaw.net>
	<4A0A5EE7.3020806@edcint.co.nz> <4A0A7ECB.2060604@themaw.net>
	<4A0B5DED.1090900@edcint.co.nz> <4A0B808C.2030705@themaw.net>
	<4A0CC262.7020105@edcint.co.nz> <4A0D1630.3040407@themaw.net>
	<4A0FC156.10108@edcint.co.nz> <4A10BC5B.7010402@themaw.net>
	<4A24BC60.1020404@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A24BC60.1020404@edcint.co.nz>
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
To: Matthew Jurgens <autofs@edcint.co.nz>
Cc: autofs@linux.kernel.org

Matthew Jurgens wrote:
> 
> Ian Kent wrote:
>> Matthew Jurgens wrote:
>>  
>>>>> Script updated and gsub commented out (like a message earlier in the
>>>>> thread):
>>>>> -fstype=cifs,username=USER,password=PASS \
>>>>>         "/C" "://xp0/C" \
>>>>>         "/ADMIN$" "://xp0/ADMIN$" \
>>>>>         "/C$" "://xp0/C$"
>>>>>
>>>>> cd /smb/xp0/C$  gives
>>>>> cd: no such file or directory: /smb/xp0/C$
>>>>>
>>>>> something is really busted now since I can't even cd /smb/xp0/C
>>>>> either.
>>>>> I don't understand why the debug log contains what looks like parts of
>>>>> the script as the output since running the script manually seems to
>>>>> have
>>>>> perfectly clean output
>>>>>             
>>>> Because the script file is not executable now it is treating it as a
>>>> file map not a program map.
>>>>       
>>> Not sure how you come to that conclusion since I ran it above to get the
>>> output and it is
>>> -rwxr-xr-x
>>>     
>>
>> Because of:
>> May 15 11:09:01 gw automount[20964]: attempting to mount entry /smb/xp0
>> May 15 11:09:01 gw automount[20964]: lookup_mount: lookup(file): looking
>> up xp0
>>
>> and since this is executed during the lookup:
>>
>> static int lookup_name_file_source_instance(struct autofs_point
>> *ap,                 struct map_source *map, const char *name, int
>> name_len)
>>         struct map_source *instance;
>>         char src_file[] = "file";
>>         char src_prog[] = "program";
>>         time_t age = time(NULL);
>>         struct stat st;
>>         char *type, *format;
>>
>>         if (stat(map->argv[0], &st) == -1) {
>>                 warn(ap->logopt, "file map not found");
>>                 return NSS_STATUS_NOTFOUND;
>>         }
>>
>>         if (!S_ISREG(st.st_mode))
>>                 return NSS_STATUS_NOTFOUND;
>>
>>         if (st.st_mode & __S_IEXEC)
>>                 type = src_prog;
>>         else
>>                 type = src_file;
>>
>>         format = map->format;
>> ....
>>
>>
>>   
> Sorry I must be missing something.
> You say autofs is now treating the script as a file since it is not
> executable but it is executable.
> I don't quite understand the "if (st.st_mode & __S_IEXEC)" part of the
> code above.

All I'm saying is that, for whatever reason, autofs is treating your
program map as a file map. Why I don't know.

The check (st.st_mode & __S_IEXEC) checks if the mode returned by the
stat(2) of the path in ap->argv[0] is executable by the owner of the file.

Ian
