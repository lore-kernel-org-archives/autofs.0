From: Ian Kent <raven@themaw.net>
Subject: Re: unable to automount windows C$
Date: Wed, 13 May 2009 13:32:48 +0800
Message-ID: <4A0A5B80.4040303@themaw.net>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A59F5.1090308@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A0A59F5.1090308@edcint.co.nz>
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
> The output of a mount command is:
>>> //xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)
>>>
>>> The incorrect target of //xp0/C/$ does not appear to be reflected in the
>>> debug output
>>>
>>> The correct output of the mount command should be:
>>> //xp0/C$ on /smb/xp0/C$ type cifs (rw,mand)
>>>     
>>
>> Clearly it isn't an autofs problem.
>> It's a mount.cifs (or mount(8)) problem.
>>
>> Ian
>>   
> I'm not quite sure how it is a mount.cifs problem since I can manually
> mount the share.
> If I can manually mount it since I pass a correct mount target, couldn't
> autofs do the same?
> Am I missing something?

Yes, when you mount it manually you don't escape the "$".
