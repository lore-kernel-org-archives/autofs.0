From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: autofs4 and NIS
Date: Mon, 05 Jan 2004 09:21:51 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FF98F1F.6010709@sedona.intel.com>
References: <200401010159.12640.autofs@dylan.me.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200401010159.12640.autofs@dylan.me.uk>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dylan <autofs@dylan.me.uk>
Cc: autofs mailing list <autofs@linux.kernel.org>

Dylan wrote:

>Hello all,
>
>I'm currently using autofs4 to mount nfs shares. The config files are 
>distributed via NIS, which overall is working without a hitch. I have 
>two related problems, however...
>
>It is, obviously, necessary to restart the NIS server from time to time, 
>in order to take account of config changes (usually changes to user 
>accounts.) When I do this, the following occurs:
>  
>
I think we need to address this issue in particular.  I can't think of 
any reason you need to restart your NIS master for config changes.  We 
have masters/slaves that have been up for years at a time without 
restarting.  These probably see > 100 map changes/pushes a day.  What 
changes are being made that a 'make' in /var/yp doesnt solve?

Also, you can set up a NIS slave/secondary to handle any connections in 
the event the master is unavailable or to help handle the load.  Then 
you always have NIS coverage.

I think if you solve this problem, the others will become non issues. 

Michael
