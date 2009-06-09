From: Ian Kent <raven@themaw.net>
Subject: Re: unable to automount windows C$
Date: Tue, 09 Jun 2009 11:05:36 +0800
Message-ID: <4A2DD180.4010303@themaw.net>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A59F5.1090308@edcint.co.nz> <4A0A5B80.4040303@themaw.net>
	<4A0A5EE7.3020806@edcint.co.nz> <4A0A7ECB.2060604@themaw.net>
	<4A0B5DED.1090900@edcint.co.nz> <4A0B808C.2030705@themaw.net>
	<4A0CC262.7020105@edcint.co.nz> <4A0D1630.3040407@themaw.net>
	<4A0FC156.10108@edcint.co.nz> <4A10BC5B.7010402@themaw.net>
	<4A24BC60.1020404@edcint.co.nz> <4A250A66.4070206@themaw.net>
	<4A271218.3030300@edcint.co.nz> <4A274C69.4090202@themaw.net>
	<4A2DADEA.3010406@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A2DADEA.3010406@edcint.co.nz>
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
>>>> All I'm saying is that, for whatever reason, autofs is treating your
>>>> program map as a file map. Why I don't know.
>>>>
>>>>       
>> It is checking if the map (path in ap->argv[0]) has the execute bit set
>> for the owner.
>>
>> Ian
>>
>>   
> So my file looks like
> -rwxr-xr-x 1 root root   1193 2009-05-16 09:53 /opt/maj/auto.samba
> Which seems to meet all the criteria - owned by root, executable by root
> etc etc

Yes, it looks OK but I don't know of any problems with this, so I'm at a
loss as to what could be happening.

Does running this script using "/opt/maj/auto.samba <some server>" work?

> 
> This is only a side issue as to why we can not automount samba paths
> ending in $
> 

Sure, but we can't check changes to the script if we can't execute it.

Ian
