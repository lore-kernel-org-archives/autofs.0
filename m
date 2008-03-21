From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: sudo and autofs
Date: Fri, 21 Mar 2008 11:45:40 +0100
Message-ID: <47E391D4.9050107@inria.fr>
References: <1203828797.5413.355.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1203828797.5413.355.camel@localhost>
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

chris barry a =E9crit :
> The question is, is there any way to make this work while preventing a
> user from accessing another user's home? Some slick program type
> automount map or something? anything...?
ugly workaround: have users copy the file in the local /tmp directory
first, before accessing it with sudo second.

Otherwise, you may have a look at kerberized nfs for a much better
security, but that's not something easy to install.
-- =

Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62
