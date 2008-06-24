From: Ian Kent <raven@themaw.net>
Subject: Re: auto home failure
Date: Tue, 24 Jun 2008 15:41:40 +0800
Message-ID: <1214293301.12623.128.camel@raven.themaw.net>
References: <07A371D457B501478C1DB3C3DE8372D701C48632@GSBHEX2V.gsb.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <07A371D457B501478C1DB3C3DE8372D701C48632@GSBHEX2V.gsb.uchicago.edu>
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
To: "Young, Darren" <Darren.Young@chicagogsb.edu>
Cc: autofs@linux.kernel.org


On Mon, 2008-06-23 at 16:55 -0500, Young, Darren wrote:
> Have an auto_home entry:
> 
>  
> 
> dn:
> automountKey=dyoung2,automountMapName=auto_home,o=gsb,dc=uchicago,dc=edu
> 
> automountInformation: gsbdata3:/export/home/&
> 
> automountKey: dyoung2 
> 
> objectClass: top
> 
> objectClass: automount
> 
>  
> 
> and get this when trying to mount:
> 
>  
> 
> Jun 22 05:24:34 gsbtestfilervm automount[14488]: attempting to mount
> entry /home/dyoung2
> 
> Jun 22 05:24:34 gsbtestfilervm automount[14488]: failed to
> mount /home/dyoung2

How about posting a debug log and version information.

Ian
