From: Ian Kent <raven@themaw.net>
Subject: Re: Automounter to dump maps
Date: Wed, 18 Nov 2009 22:41:39 +0800
Message-ID: <4B0407A3.5050202@themaw.net>
References: <4AFC0BEB.3040808@s3group.cz> <4AFC212C.4010409@themaw.net>
	<4AFC40F5.80909@s3group.cz> <4B0256E5.7060702@themaw.net>
	<4B03FD12.8050100@s3group.cz> <4B0400D2.4080402@themaw.net>
	<4B04054F.3060208@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B04054F.3060208@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Ondrej Valousek wrote:
> 
>> No, that's the right thing to do.
>> I'm still thinking about how to do it, while working on other things.
>> It's a bit hard actually.
>>
>>   
> 
> I think I understand - automounter is demand driven right? So that means
> that only those indirect maps being used are looked for and loaded.
> Direct maps is an exception to this - these are always loaded.
> Anyway - hope you'll eventually find some elegant solution - I
> appreciate this.....

It's a bit more than that, it's the code structure as well.
Something that Jeff has complained about before.
Anyway, hopefully I'll come up with something.

Ian
