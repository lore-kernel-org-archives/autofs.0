From: <Scott_Rochford@DELL.com>
Subject: Re: autofs 5 not recognizing manual umounts properly
Date: Mon, 30 Oct 2006 09:53:21 -0000
Message-ID: <0F5A1C742BC73849AFF518F1F8249D4D0181D723@mtpx3m2.mtp.emea.dell.com>
References: <1162190102.2900.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1162190102.2900.13.camel@localhost>
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
To: autofs@linux.kernel.org

> I'm likely to end up saying that manual umounting of automounted 
> shares is a bad thing and doing so may lead to unpredictable 
> behavior. I may be able to improve matters but it is unlikely to be 
> totally reliable.
> So I recommend leaving the automounts alone.

In an ideal world, yes of course, but in reality in large production
environments with NFS servers going down and/or hanging from time to
time for various reasons I think it's a situation that needs to be
accounted for.

Failing that, an alternative procedure?  Stop the automounter, unmount,
and restart it perhaps?
--
Regards,
Scott Rochford
