From: raven@themaw.net
Subject: Re: autofs and terminal networks woes.
Date: Thu, 17 Feb 2005 22:10:58 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502172203440.1683@donald.themaw.net>
References: <215ff441050217023378003e72@mail.gmail.com> 
	<Pine.LNX.4.61.0502172136030.1683@donald.themaw.net>
	<215ff441050217060647db41dc@mail.gmail.com>
Mime-Version: 1.0
In-Reply-To: <215ff441050217060647db41dc@mail.gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Chris Fanning <christopher.fanning@gmail.com>
Cc: autofs@linux.kernel.org

On Thu, 17 Feb 2005, Chris Fanning wrote:

> Hi Ian,
>
>> Versions?
>>
> 4.1.3-9
>
>> Perhaps you need to use ://thinclient_ip/fd
>
> So, do you suggest I upgrade?

Only if you can solve the problems you face. Certainly not without plenty 
of testing.

> When might 4.1.4 be available for debian testing?

I guess that will depend on the Debian folks.
I'm hoping they will push 4.1.4 into the Debian tree fairly soon after it 
is released. I've tried to get as many fixes into the new version as I could.

> Should I download the source instead?

If you wish to test this out you can download 
autofs-4.1.4_beta2-deb.tar.gz which basically contains the files of a 
source deb.

As i've said before, this is for testing only as I'm not the maintainer of 
the Debian package.

If you do try this make sure you stop autofs before installing the deb.

Ian
