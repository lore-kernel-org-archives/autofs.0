From: Sven Ulland <sveniu@ifi.uio.no>
Subject: Re: Change dn of auto.master for autofs+ldap
Date: Sat, 26 Aug 2006 08:10:23 +0200
Message-ID: <44EFE5CF.4020706@ifi.uio.no>
References: <44EF67A2.2090905@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44EF67A2.2090905@ifi.uio.no>
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

Sven Ulland wrote:
> I'm setting up autofs in ldap, i.e. I'm not using the /etc/auto.*
> files at all. Now, I'm wondering how to change the distinguished name
> of auto.master in the database.

Oh right. Just put it under any ou and it works without
having to configure anything. Sweet.

sven
