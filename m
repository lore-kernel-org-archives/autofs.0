From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: expire_indirect errors in the syslog
Date: Fri, 07 Nov 2008 08:42:17 +0100
Message-ID: <4913F159.5000002@s3group.cz>
References: <4906C365.8030209@s3group.cz>	
	<1225181075.2938.97.camel@zeus.themaw.net>
	<4906CB2A.9010705@s3group.cz>	
	<1225192753.2938.103.camel@zeus.themaw.net>
	<4912E18F.7010701@s3group.cz>
	<1226020830.3093.22.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1226020830.3093.22.camel@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Ian,

I guess I can not turn debugging on without restarting autofs, right?
This is a production login box with many users logged in. My experience
says restarting autofs would freeze the machine.
Thanks,

Ondrej
> This specific example should not result in those messages.
> If you want further analysis of this issue then post a full debug log.
>
> Ian
>
>
>   
