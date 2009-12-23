From: Stef Bon <stef@bononline.nl>
Subject: Re: sshfs and autofs
Date: Wed, 23 Dec 2009 23:19:06 +0100
Message-ID: <4B32975A.2030902@bononline.nl>
References: <1261107485-sup-320@nixos> <1261173402-sup-9510@nixos>
	<4B2E48C7.8010509@bononline.nl> <1261391275-sup-7258@nixos>
	<4B311928.9070503@bononline.nl> <1261518309-sup-4721@nixos>
	<4B329000.3060101@bononline.nl> <1261605772-sup-1554@nixos>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1261605772-sup-1554@nixos>
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
To: Marc Weber <marco-oweber@gmx.de>
Cc: autofs <autofs@linux.kernel.org>

Marc Weber wrote:
>> I think that your script tries to offer a dialog somehere, but that it 
>> does not reach you as user...
>>     
>
> No, it doesn't  because it would have been too much work thinking about
> how to present that.
>   DISPLAY=:0.0 some_dialog
>
> does work for X and (my) current use case. But it doesn't work for all
> use cases.
>
> So my script the user knows about this issue and will run
>
> ssh-add manually before mounting anything.
>
> Marc Weber
>
>   

Well exactly!. I get it, this is a way to make this work.

Do you think this is ok, or don't you want this manually thing??

Stef
