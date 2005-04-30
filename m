From: Robert Swan <rswanster@gmail.com>
Subject: Re: debug failed automount
Date: Sat, 30 Apr 2005 01:27:17 -0400
Message-ID: <11101302050429222770e0df9d@mail.gmail.com>
References: <11101302050428071921ec8bb7@mail.gmail.com>
Reply-To: Robert Swan <rswanster@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <11101302050428071921ec8bb7@mail.gmail.com>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

> 
> One point is that the remote host is accessed through a VPN tunnel.

so as it turns out, this is the problem. The rpc_time call fails (I
assume this is because it is not supported by the VPN) and this marks
my only host as dead and automount does not attempt to mount. Even
though the mount actually works fine.

I made myself a little patch to overcome the problem. I think someone
suggested that the rpc_ping stuff should be used to to rank the hosts,
and that mount should try all of them before giving up. Seems like a
good idea.

Robert
