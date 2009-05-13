From: Ian Kent <raven@themaw.net>
Subject: Re: unable to automount windows C$
Date: Wed, 13 May 2009 16:09:24 +0800
Message-ID: <4A0A8034.40304@themaw.net>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>	<1230012791.3043.6.camel@zeus.themaw.net>	<4A07749D.4000406@edcint.co.nz>
	<4A08FEE6.7000604@themaw.net>	<4A0A533A.3060203@edcint.co.nz>
	<4A0A5527.2060207@themaw.net>	<4A0A59F5.1090308@edcint.co.nz>
	<4A0A5B80.4040303@themaw.net> <4A0A5EE7.3020806@edcint.co.nz>
	<4A0A6178.7090003@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A0A6178.7090003@edcint.co.nz>
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
> Yes, when you mount it manually you don't escape the "$"
> 
>> If I manually mount it using:
>> mount -t cifs -o username=mjurgens,password=parallel12 //xp0/C$ /mnt/C$
>> it works. If I also escape the $ then it also works
>> mount -t cifs -o username=mjurgens,password=parallel12 //xp0/C\$ /mnt/C\$
>>
>> Was that what you were talking about?
>>
>> _______________________________________________
>> autofs mailing list
>> autofs@linux.kernel.org
>> http://linux.kernel.org/mailman/listinfo/autofs
>>   
> When I was on Fedora 8 and autofs-5.0.2-16
> <http://koji.fedoraproject.org/koji/buildinfo?buildID=46891>
> <http://koji.fedoraproject.org/koji/buildinfo?buildID=46891> it worked
> Then when I upgraded only autofs to 5.0.3 it was broken
> Doesn't that suggest that it is something in the autofs code that can
> therefore be potentially fixed?
> 

Maybe.

There is always the possibility of working around things like this.
But it may not be a simple matter to change this as lot of change has
taken place.
