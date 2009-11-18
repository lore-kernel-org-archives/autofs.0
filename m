From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: Automounter to dump maps
Date: Wed, 18 Nov 2009 15:31:43 +0100
Message-ID: <4B04054F.3060208@s3group.cz>
References: <4AFC0BEB.3040808@s3group.cz> <4AFC212C.4010409@themaw.net>
	<4AFC40F5.80909@s3group.cz> <4B0256E5.7060702@themaw.net>
	<4B03FD12.8050100@s3group.cz> <4B0400D2.4080402@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B0400D2.4080402@themaw.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>


> No, that's the right thing to do.
> I'm still thinking about how to do it, while working on other things.
> It's a bit hard actually.
>
>   

I think I understand - automounter is demand driven right? So that means 
that only those indirect maps being used are looked for and loaded. 
Direct maps is an exception to this - these are always loaded.
Anyway - hope you'll eventually find some elegant solution - I 
appreciate this.....

Ondrej
