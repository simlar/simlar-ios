
/*
LinphoneEnums.swift
Copyright (C) 2019 Belledonne Communications SARL

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/
import Foundation
import linphone

///Enum describing RTP AVPF activation modes. 
public enum AVPFMode:Int
{
	/// Use default value defined at upper level. 
	case Default = -1
	/// AVPF is disabled. 
	case Disabled = 0
	/// AVPF is enabled. 
	case Enabled = 1
}
///Enum algorithm checking. 
public enum AccountCreatorAlgoStatus:Int
{
	/// Algorithm ok. 
	case Ok = 0
	/// Algorithm not supported. 
	case NotSupported = 1
}
///Enum describing Ip family. 
public enum AddressFamily:Int
{
	/// IpV4. 
	case Inet = 0
	/// IpV6. 
	case Inet6 = 1
	/// Unknown. 
	case Unspec = 2
}
///Enum describing type of audio route. 
public enum AudioRoute:Int
{
	case Earpiece = 0
	case Speaker = 1
}
///Enum describing the authentication methods. 
public enum AuthMethod:Int
{
	/// Digest authentication requested. 
	case HttpDigest = 0
	/// Client certificate requested. 
	case Tls = 1
}
///LinphoneChatRoomBackend is used to indicate the backend implementation of a
///chat room. 
public struct ChatRoomBackend:OptionSet
{
	public let rawValue: Int

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	/// Basic (client-to-client) chat room. 
	public static let Basic = ChatRoomBackend(rawValue: 1<<0)
	/// Server-based chat room. 
	public static let FlexisipChat = ChatRoomBackend(rawValue: 1<<1)
}
///LinphoneChatRoomCapabilities is used to indicate the capabilities of a chat
///room. 
public struct ChatRoomCapabilities:OptionSet
{
	public let rawValue: Int

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	/// No capabilities. 
	public static let None = ChatRoomCapabilities(rawValue: 0)
	/// No server. 
	public static let Basic = ChatRoomCapabilities(rawValue: 1<<0)
	/// Supports RTT. 
	public static let RealTimeText = ChatRoomCapabilities(rawValue: 1<<1)
	/// Use server (supports group chat) 
	public static let Conference = ChatRoomCapabilities(rawValue: 1<<2)
	/// Special proxy chat room flag. 
	public static let Proxy = ChatRoomCapabilities(rawValue: 1<<3)
	/// Chat room migratable from Basic to Conference. 
	public static let Migratable = ChatRoomCapabilities(rawValue: 1<<4)
	/// A communication between two participants (can be Basic or Conference) 
	public static let OneToOne = ChatRoomCapabilities(rawValue: 1<<5)
	/// Chat room is encrypted. 
	public static let Encrypted = ChatRoomCapabilities(rawValue: 1<<6)
}
///LinphoneChatRoomEncryptionBackend is used to indicate the encryption engine
///used by a chat room. 
public struct ChatRoomEncryptionBackend:OptionSet
{
	public let rawValue: Int

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	/// No encryption. 
	public static let None = ChatRoomEncryptionBackend(rawValue: 0)
	/// Lime x3dh encryption. 
	public static let Lime = ChatRoomEncryptionBackend(rawValue: 1<<0)
}
///TODO move to encryption engine object when available
///LinphoneChatRoomSecurityLevel is used to indicate the encryption security level
///of a chat room. 
public enum ChatRoomSecurityLevel:Int
{
	/// Security failure. 
	case Unsafe = 0
	/// No encryption. 
	case ClearText = 1
	/// Encrypted. 
	case Encrypted = 2
	/// Encrypted and verified. 
	case Safe = 3
}
///LinphoneGlobalState describes the global state of the `Core` object. 
public enum ConfiguringState:Int
{
	case Successful = 0
	case Failed = 1
	case Skipped = 2
}
///Consolidated presence information: 'online' means the user is open for
///communication, 'busy' means the user is open for communication but involved in
///an other activity, 'do not disturb' means the user is not open for
///communication, and 'offline' means that no presence information is available. 
public enum ConsolidatedPresence:Int
{
	case Online = 0
	case Busy = 1
	case DoNotDisturb = 2
	case Offline = 3
}
///Enum describing the result of the echo canceller calibration process. 
public enum EcCalibratorStatus:Int
{
	/// The echo canceller calibration process is on going. 
	case InProgress = 0
	/// The echo canceller calibration has been performed and produced an echo delay
	/// measure. 
	case Done = 1
	/// The echo canceller calibration process has failed. 
	case Failed = 2
	/// The echo canceller calibration has been performed and no echo has been
	/// detected. 
	case DoneNoEcho = 3
}
///LinphoneEventLogType is used to indicate the type of an event. 
public enum EventLogType:Int
{
	/// No defined event. 
	case None = 0
	/// Conference (created) event. 
	case ConferenceCreated = 1
	/// Conference (terminated) event. 
	case ConferenceTerminated = 2
	/// Conference call (start) event. 
	case ConferenceCallStart = 3
	/// Conference call (end) event. 
	case ConferenceCallEnd = 4
	/// Conference chat message event. 
	case ConferenceChatMessage = 5
	/// Conference participant (added) event. 
	case ConferenceParticipantAdded = 6
	/// Conference participant (removed) event. 
	case ConferenceParticipantRemoved = 7
	/// Conference participant (set admin) event. 
	case ConferenceParticipantSetAdmin = 8
	/// Conference participant (unset admin) event. 
	case ConferenceParticipantUnsetAdmin = 9
	/// Conference participant device (added) event. 
	case ConferenceParticipantDeviceAdded = 10
	/// Conference participant device (removed) event. 
	case ConferenceParticipantDeviceRemoved = 11
	/// Conference subject event. 
	case ConferenceSubjectChanged = 12
	/// Conference encryption security event. 
	case ConferenceSecurityEvent = 13
	/// Conference ephemeral message (ephemeral message lifetime changed) event. 
	case ConferenceEphemeralMessageLifetimeChanged = 14
	/// Conference ephemeral message (ephemeral message enabled) event. 
	case ConferenceEphemeralMessageEnabled = 15
	/// Conference ephemeral message (ephemeral message disabled) event. 
	case ConferenceEphemeralMessageDisabled = 16
}
///Enum describing the status of a LinphoneFriendList operation. 
public struct FriendCapability:OptionSet
{
	public let rawValue: Int

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	public static let None = FriendCapability(rawValue: 0)
	public static let GroupChat = FriendCapability(rawValue: 1<<0)
	public static let LimeX3Dh = FriendCapability(rawValue: 1<<1)
	public static let EphemeralMessages = FriendCapability(rawValue: 1<<2)
}
///LinphoneGlobalState describes the global state of the `Core` object. 
public enum GlobalState:Int
{
	/// State in which we're in after {@link Core#stop}. 
	case Off = 0
	/// Transient state for when we call {@link Core#start} 
	case Startup = 1
	/// Indicates `Core` has been started and is up and running. 
	case On = 2
	/// Transient state for when we call {@link Core#stop} 
	case Shutdown = 3
	/// Transient state between Startup and On if there is a remote provisionning URI
	/// configured. 
	case Configuring = 4
	/// `Core` state after being created by linphone_factory_create_core, generally
	/// followed by a call to {@link Core#start} 
	case Ready = 5
}
///Enum describing ICE states. 
public enum IceState:Int
{
	/// ICE has not been activated for this call or stream. 
	case NotActivated = 0
	/// ICE processing has failed. 
	case Failed = 1
	/// ICE process is in progress. 
	case InProgress = 2
	/// ICE has established a direct connection to the remote host. 
	case HostConnection = 3
	/// ICE has established a connection to the remote host through one or several
	/// NATs. 
	case ReflexiveConnection = 4
	/// ICE has established a connection through a relay. 
	case RelayConnection = 5
}
public enum LimeState:Int
{
	/// Lime is not used at all. 
	case Disabled = 0
	/// Lime is always used. 
	case Mandatory = 1
	/// Lime is used only if we already shared a secret with remote. 
	case Preferred = 2
}
public enum LogCollectionState:Int
{
	case Disabled = 0
	case Enabled = 1
	case EnabledWithoutPreviousLogHandler = 2
}
///Verbosity levels of log messages. 
public struct LogLevel:OptionSet
{
	public let rawValue: Int

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	/// Level for debug messages. 
	public static let Debug = LogLevel(rawValue: 1)
	/// Level for traces. 
	public static let Trace = LogLevel(rawValue: 1<<1)
	/// Level for information messages. 
	public static let Message = LogLevel(rawValue: 1<<2)
	/// Level for warning messages. 
	public static let Warning = LogLevel(rawValue: 1<<3)
	/// Level for error messages. 
	public static let Error = LogLevel(rawValue: 1<<4)
	/// Level for fatal error messages. 
	public static let Fatal = LogLevel(rawValue: 1<<5)
}
///Indicates for a given media the stream direction. 
public enum MediaDirection:Int
{
	case Invalid = -1
	case Inactive = 0
	/// No active media not supported yet. 
	case SendOnly = 1
	/// Send only mode. 
	case RecvOnly = 2
	/// recv only mode 
	case SendRecv = 3
}
///Enum describing type of media encryption types. 
public enum MediaEncryption:Int
{
	/// No media encryption is used. 
	case None = 0
	/// Use SRTP media encryption. 
	case SRTP = 1
	/// Use ZRTP media encryption. 
	case ZRTP = 2
	/// Use DTLS media encryption. 
	case DTLS = 3
}
///Activities as defined in section 3.2 of RFC 4480. 
public enum PresenceActivityType:Int
{
	/// The person has a calendar appointment, without specifying exactly of what type. 
	case Appointment = 0
	/// The person is physically away from all interactive communication devices. 
	case Away = 1
	/// The person is eating the first meal of the day, usually eaten in the morning. 
	case Breakfast = 2
	/// The person is busy, without further details. 
	case Busy = 3
	/// The person is having his or her main meal of the day, eaten in the evening or
	/// at midday. 
	case Dinner = 4
	/// This is a scheduled national or local holiday. 
	case Holiday = 5
	/// The person is riding in a vehicle, such as a car, but not steering. 
	case InTransit = 6
	/// The person is looking for (paid) work. 
	case LookingForWork = 7
	/// The person is eating his or her midday meal. 
	case Lunch = 8
	/// The person is scheduled for a meal, without specifying whether it is breakfast,
	/// lunch, or dinner, or some other meal. 
	case Meal = 9
	/// The person is in an assembly or gathering of people, as for a business, social,
	/// or religious purpose. 
	case Meeting = 10
	/// The person is talking on the telephone. 
	case OnThePhone = 11
	/// The person is engaged in an activity with no defined representation. 
	case Other = 12
	/// A performance is a sub-class of an appointment and includes musical,
	/// theatrical, and cinematic performances as well as lectures. 
	case Performance = 13
	/// The person will not return for the foreseeable future, e.g., because it is no
	/// longer working for the company. 
	case PermanentAbsence = 14
	/// The person is occupying himself or herself in amusement, sport, or other
	/// recreation. 
	case Playing = 15
	/// The person is giving a presentation, lecture, or participating in a formal
	/// round-table discussion. 
	case Presentation = 16
	/// The person is visiting stores in search of goods or services. 
	case Shopping = 17
	/// The person is sleeping. 
	case Sleeping = 18
	/// The person is observing an event, such as a sports event. 
	case Spectator = 19
	/// The person is controlling a vehicle, watercraft, or plane. 
	case Steering = 20
	/// The person is on a business or personal trip, but not necessarily in-transit. 
	case Travel = 21
	/// The person is watching television. 
	case TV = 22
	/// The activity of the person is unknown. 
	case Unknown = 23
	/// A period of time devoted to pleasure, rest, or relaxation. 
	case Vacation = 24
	/// The person is engaged in, typically paid, labor, as part of a profession or
	/// job. 
	case Working = 25
	/// The person is participating in religious rites. 
	case Worship = 26
}
///Basic status as defined in section 4.1.4 of RFC 3863. 
public enum PresenceBasicStatus:Int
{
	/// This value means that the associated contact element, if any, is ready to
	/// accept communication. 
	case Open = 0
	/// This value means that the associated contact element, if any, is unable to
	/// accept communication. 
	case Closed = 1
}
///Defines privacy policy to apply as described by rfc3323. 
public enum Privacy:Int
{
	/// Privacy services must not perform any privacy function. 
	case None = 0
	/// Request that privacy services provide a user-level privacy function. 
	case User = 1
	/// Request that privacy services modify headers that cannot be set arbitrarily by
	/// the user (Contact/Via). 
	case Header = 2
	/// Request that privacy services provide privacy for session media. 
	case Session = 4
	/// rfc3325 The presence of this privacy type in a Privacy header field indicates
	/// that the user would like the Network Asserted Identity to be kept private with
	/// respect to SIP entities outside the Trust Domain with which the user
	/// authenticated. 
	case Id = 8
	/// Privacy service must perform the specified services or fail the request. 
	case Critical = 16
	/// Special keyword to use privacy as defined either globally or by proxy using
	/// {@link ProxyConfig#setPrivacy} 
	case Default = 32768
}
///Enum for publish states. 
public enum PublishState:Int
{
	/// Initial state, do not use. 
	case None = 0
	/// An outgoing publish was created and submitted. 
	case Progress = 1
	/// Publish is accepted. 
	case Ok = 2
	/// Publish encoutered an error, {@link Event#getReason} gives reason code. 
	case Error = 3
	/// Publish is about to expire, only sent if [sip]->refresh_generic_publish
	/// property is set to 0. 
	case Expiring = 4
	/// Event has been un published. 
	case Cleared = 5
}
///Enum describing various failure reasons or contextual information for some
///events. 
public enum Reason:Int
{
	/// No reason has been set by the core. 
	case None = 0
	/// No response received from remote. 
	case NoResponse = 1
	/// Authentication failed due to bad credentials or resource forbidden. 
	case Forbidden = 2
	/// The call has been declined. 
	case Declined = 3
	/// Destination of the call was not found. 
	case NotFound = 4
	/// The call was not answered in time (request timeout) 
	case NotAnswered = 5
	/// Phone line was busy. 
	case Busy = 6
	/// Unsupported content. 
	case UnsupportedContent = 7
	/// Transport error: connection failures, disconnections etc... 
	case IOError = 8
	/// Do not disturb reason. 
	case DoNotDisturb = 9
	/// Operation is unauthorized because missing credential. 
	case Unauthorized = 10
	/// Operation is rejected due to incompatible or unsupported media parameters. 
	case NotAcceptable = 11
	/// Operation could not be executed by server or remote client because it didn't
	/// have any context for it. 
	case NoMatch = 12
	/// Resource moved permanently. 
	case MovedPermanently = 13
	/// Resource no longer exists. 
	case Gone = 14
	/// Temporarily unavailable. 
	case TemporarilyUnavailable = 15
	/// Address incomplete. 
	case AddressIncomplete = 16
	/// Not implemented. 
	case NotImplemented = 17
	/// Bad gateway. 
	case BadGateway = 18
	/// The received request contains a Session-Expires header field with a duration
	/// below the minimum timer. 
	case SessionIntervalTooSmall = 19
	/// Server timeout. 
	case ServerTimeout = 20
	/// Unknown reason. 
	case Unknown = 21
}
///LinphoneRegistrationState describes proxy registration states. 
public enum RegistrationState:Int
{
	/// Initial state for registrations. 
	case None = 0
	/// Registration is in progress. 
	case Progress = 1
	/// Registration is successful. 
	case Ok = 2
	/// Unregistration succeeded. 
	case Cleared = 3
	/// Registration failed. 
	case Failed = 4
}
///LinphoneSecurityEventType is used to indicate the type of security event. 
public enum SecurityEventType:Int
{
	/// Event is not a security event. 
	case None = 0
	/// Chatroom security level downgraded event. 
	case SecurityLevelDowngraded = 1
	/// Participant has exceeded the maximum number of device event. 
	case ParticipantMaxDeviceCountExceeded = 2
	/// Peer device instant messaging encryption identity key has changed event. 
	case EncryptionIdentityKeyChanged = 3
	/// Man in the middle detected event. 
	case ManInTheMiddleDetected = 4
}
///Session Timers refresher. 
public enum SessionExpiresRefresher:Int
{
	case Unspecified = 0
	case UAS = 1
	case UAC = 2
}
///Enum describing the stream types. 
public enum StreamType:Int
{
	case Audio = 0
	case Video = 1
	case Text = 2
	case Unknown = 3
}
///Enum controlling behavior for incoming subscription request. 
public enum SubscribePolicy:Int
{
	/// Does not automatically accept an incoming subscription request. 
	case SPWait = 0
	/// Rejects incoming subscription request. 
	case SPDeny = 1
	/// Automatically accepts a subscription request. 
	case SPAccept = 2
}
///Enum for subscription direction (incoming or outgoing). 
public enum SubscriptionDir:Int
{
	/// Incoming subscription. 
	case Incoming = 0
	/// Outgoing subscription. 
	case Outgoing = 1
	/// Invalid subscription direction. 
	case InvalidDir = 2
}
///Enum for subscription states. 
public enum SubscriptionState:Int
{
	/// Initial state, should not be used. 
	case None = 0
	/// An outgoing subcription was sent. 
	case OutgoingProgress = 1
	/// An incoming subcription is received. 
	case IncomingReceived = 2
	/// Subscription is pending, waiting for user approval. 
	case Pending = 3
	/// Subscription is accepted. 
	case Active = 4
	/// Subscription is terminated normally. 
	case Terminated = 5
	/// Subscription was terminated by an error, indicated by {@link Event#getReason} 
	case Error = 6
	/// Subscription is about to expire, only sent if [sip]->refresh_generic_subscribe
	/// property is set to 0. 
	case Expiring = 7
}
///Enum listing frequent telephony tones. 
public enum ToneID:Int
{
	/// Not a tone. 
	case Undefined = 0
	/// Busy tone. 
	case Busy = 1
	case CallWaiting = 2
	/// Call waiting tone. 
	case CallOnHold = 3
	/// Call on hold tone. 
	case CallLost = 4
}
///Enum describing transport type for LinphoneAddress. 
public enum TransportType:Int
{
	case Udp = 0
	case Tcp = 1
	case Tls = 2
	case Dtls = 3
}
///Enum describing uPnP states. 
public enum UpnpState:Int
{
	/// uPnP is not activate 
	case Idle = 0
	/// uPnP process is in progress 
	case Pending = 1
	/// Internal use: Only used by port binding. 
	case Adding = 2
	/// Internal use: Only used by port binding. 
	case Removing = 3
	/// uPnP is not available 
	case NotAvailable = 4
	/// uPnP is enabled 
	case Ok = 5
	/// uPnP processing has failed 
	case Ko = 6
	/// IGD router is blacklisted. 
	case Blacklisted = 7
}
///Enum describing the result of a version update check. 
public enum VersionUpdateCheckResult:Int
{
	case UpToDate = 0
	case NewVersionAvailable = 1
	case Error = 2
}
///Enum describing the types of argument for LinphoneXmlRpcRequest. 
public enum XmlRpcArgType:Int
{
	case None = 0
	case Int = 1
	case String = 2
	case StringStruct = 3
}
///Enum describing the status of a LinphoneXmlRpcRequest. 
public enum XmlRpcStatus:Int
{
	case Pending = 0
	case Ok = 1
	case Failed = 2
}
///Enum describing the ZRTP SAS validation status of a peer URI. 
public enum ZrtpPeerStatus:Int
{
	/// Peer URI unkown or never validated/invalidated the SAS. 
	case Unknown = 0
	/// Peer URI SAS rejected in database. 
	case Invalid = 1
	/// Peer URI SAS validated in database. 
	case Valid = 2
}


func charArrayToString(charPointer: UnsafePointer<CChar>?) -> String {
	return charPointer != nil ? String(cString: charPointer!) : ""
}

/// Class basic linphone class
public class LinphoneObject {
	var cPtr:OpaquePointer?

	/*!
     Initializes a new LinphoneObject with the provided cPointer.

     - Parameters:
        - cPointer: The OpaquePointer of c lib

     - Returns: new LinphoneObject
  */
	init(cPointer:OpaquePointer) {
		cPtr = cPointer
		belle_sip_object_ref(UnsafeMutableRawPointer(cPtr))
	}

	deinit {
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  nil, nil)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPtr))
	}
}

func StringArrayToBctbxList(list: [String]) -> UnsafeMutablePointer<bctbx_list_t>? {
	var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
	for data in list {
		let sData:NSString = data as NSString
		cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
	}
	return cList
}

func BctbxListToStringArray(list: UnsafeMutablePointer<bctbx_list_t>) -> [String]? {
	var sList = [String]()
	var cList = list
	while (cList.pointee.data != nil) {
		sList.append(String(cString: unsafeBitCast(cList.pointee.data, to: UnsafePointer<CChar>.self)))
		cList = UnsafeMutablePointer<bctbx_list_t>(cList.pointee.next)
	}
	return sList
}

func ObjectArrayToBctbxList<T:LinphoneObject>(list: [T]) -> UnsafeMutablePointer<bctbx_list_t>? {
	var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
	for data in list {
		cList = bctbx_list_append(cList, UnsafeMutableRawPointer(data.cPtr))
	}
	return cList
}

protocol LinphoneObjectDelegate {
	var cPtr: OpaquePointer {get set}
}

enum LinphoneError: Error {
	case exception(result: String)
}


open class AccountCreatorDelegate : LinphoneObjectDelegate
{
	var cPtr: OpaquePointer

	public init() {
		self.cPtr = linphone_factory_create_account_creator_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)

		linphone_account_creator_cbs_set_activate_account(cPtr, { (creator, status, resp) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentCallbacks
				delegate?.onActivateAccount(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, resp: charArrayToString(charPointer: resp))
			}
		})

		linphone_account_creator_cbs_set_activate_alias(cPtr, { (creator, status, resp) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentCallbacks
				delegate?.onActivateAlias(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, resp: charArrayToString(charPointer: resp))
			}
		})

		linphone_account_creator_cbs_set_is_account_linked(cPtr, { (creator, status, resp) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentCallbacks
				delegate?.onIsAccountLinked(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, resp: charArrayToString(charPointer: resp))
			}
		})

		linphone_account_creator_cbs_set_link_account(cPtr, { (creator, status, resp) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentCallbacks
				delegate?.onLinkAccount(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, resp: charArrayToString(charPointer: resp))
			}
		})

		linphone_account_creator_cbs_set_is_alias_used(cPtr, { (creator, status, resp) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentCallbacks
				delegate?.onIsAliasUsed(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, resp: charArrayToString(charPointer: resp))
			}
		})

		linphone_account_creator_cbs_set_is_account_activated(cPtr, { (creator, status, resp) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentCallbacks
				delegate?.onIsAccountActivated(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, resp: charArrayToString(charPointer: resp))
			}
		})

		linphone_account_creator_cbs_set_login_linphone_account(cPtr, { (creator, status, resp) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentCallbacks
				delegate?.onLoginLinphoneAccount(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, resp: charArrayToString(charPointer: resp))
			}
		})

		linphone_account_creator_cbs_set_is_account_exist(cPtr, { (creator, status, resp) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentCallbacks
				delegate?.onIsAccountExist(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, resp: charArrayToString(charPointer: resp))
			}
		})

		linphone_account_creator_cbs_set_update_account(cPtr, { (creator, status, resp) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentCallbacks
				delegate?.onUpdateAccount(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, resp: charArrayToString(charPointer: resp))
			}
		})

		linphone_account_creator_cbs_set_recover_account(cPtr, { (creator, status, resp) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentCallbacks
				delegate?.onRecoverAccount(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, resp: charArrayToString(charPointer: resp))
			}
		})

		linphone_account_creator_cbs_set_create_account(cPtr, { (creator, status, resp) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentCallbacks
				delegate?.onCreateAccount(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, resp: charArrayToString(charPointer: resp))
			}
		})
	}

	deinit {
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  nil, nil)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPtr))
	}

	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object 
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// 
	open func onActivateAccount(creator: AccountCreator, status: AccountCreator.Status, resp: String) {}
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object 
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// 
	open func onActivateAlias(creator: AccountCreator, status: AccountCreator.Status, resp: String) {}
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object 
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// 
	open func onIsAccountLinked(creator: AccountCreator, status: AccountCreator.Status, resp: String) {}
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object 
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// 
	open func onLinkAccount(creator: AccountCreator, status: AccountCreator.Status, resp: String) {}
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object 
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// 
	open func onIsAliasUsed(creator: AccountCreator, status: AccountCreator.Status, resp: String) {}
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object 
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// 
	open func onIsAccountActivated(creator: AccountCreator, status: AccountCreator.Status, resp: String) {}
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object 
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// 
	open func onLoginLinphoneAccount(creator: AccountCreator, status: AccountCreator.Status, resp: String) {}
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object 
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// 
	open func onIsAccountExist(creator: AccountCreator, status: AccountCreator.Status, resp: String) {}
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object 
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// 
	open func onUpdateAccount(creator: AccountCreator, status: AccountCreator.Status, resp: String) {}
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object 
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// 
	open func onRecoverAccount(creator: AccountCreator, status: AccountCreator.Status, resp: String) {}
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object 
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// 
	open func onCreateAccount(creator: AccountCreator, status: AccountCreator.Status, resp: String) {}
}

open class CallDelegate : LinphoneObjectDelegate
{
	var cPtr: OpaquePointer

	public init() {
		self.cPtr = linphone_factory_create_call_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)

		linphone_call_cbs_set_camera_not_working(cPtr, { (call, cameraName) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentCallbacks
				delegate?.onCameraNotWorking(call: sObject, cameraName: charArrayToString(charPointer: cameraName))
			}
		})

		linphone_call_cbs_set_snapshot_taken(cPtr, { (call, filepath) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentCallbacks
				delegate?.onSnapshotTaken(call: sObject, filepath: charArrayToString(charPointer: filepath))
			}
		})

		linphone_call_cbs_set_state_changed(cPtr, { (call, cstate, message) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentCallbacks
				delegate?.onStateChanged(call: sObject, cstate: Call.State(rawValue: Int(cstate.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})

		linphone_call_cbs_set_transfer_state_changed(cPtr, { (call, cstate) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentCallbacks
				delegate?.onTransferStateChanged(call: sObject, cstate: Call.State(rawValue: Int(cstate.rawValue))!)
			}
		})

		linphone_call_cbs_set_tmmbr_received(cPtr, { (call, streamIndex, tmmbr) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentCallbacks
				delegate?.onTmmbrReceived(call: sObject, streamIndex: Int(streamIndex), tmmbr: Int(tmmbr))
			}
		})

		linphone_call_cbs_set_info_message_received(cPtr, { (call, msg) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentCallbacks
				delegate?.onInfoMessageReceived(call: sObject, msg: InfoMessage.getSwiftObject(cObject: msg!))
			}
		})

		linphone_call_cbs_set_encryption_changed(cPtr, { (call, on, authenticationToken) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentCallbacks
				delegate?.onEncryptionChanged(call: sObject, on: on != 0, authenticationToken: charArrayToString(charPointer: authenticationToken))
			}
		})

		linphone_call_cbs_set_ack_processing(cPtr, { (call, ack, isReceived) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentCallbacks
				delegate?.onAckProcessing(call: sObject, ack: Headers.getSwiftObject(cObject: ack!), isReceived: isReceived != 0)
			}
		})

		linphone_call_cbs_set_dtmf_received(cPtr, { (call, dtmf) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentCallbacks
				delegate?.onDtmfReceived(call: sObject, dtmf: Int(dtmf))
			}
		})

		linphone_call_cbs_set_next_video_frame_decoded(cPtr, { (call) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentCallbacks
				delegate?.onNextVideoFrameDecoded(call: sObject)
			}
		})

		linphone_call_cbs_set_stats_updated(cPtr, { (call, stats) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentCallbacks
				delegate?.onStatsUpdated(call: sObject, stats: CallStats.getSwiftObject(cObject: stats!))
			}
		})
	}

	deinit {
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  nil, nil)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPtr))
	}

	///	Callback to notify that the camera is not working and has been changed to "No
	///	Webcam". 
	/// A camera is detected as mis-functionning as soon as it outputs no frames at all
	/// during a period of 5 seconds. This check is only performed on desktop
	/// platforms, in the purpose of notifying camera failures, for example if when a
	/// usb cable gets disconnected.
	/// 
	/// - Parameter call: LinphoneCall for which the next video frame has been decoded 
	/// - Parameter cameraName: the name of the non-working camera 
	/// 
	open func onCameraNotWorking(call: Call, cameraName: String) {}
	///	Callback for notifying a snapshot taken. 
	/// - Parameter call: LinphoneCall for which the snapshot was taken 
	/// - Parameter filepath: the name of the saved file 
	/// 
	open func onSnapshotTaken(call: Call, filepath: String) {}
	///	Call state notification callback. 
	/// - Parameter call: LinphoneCall whose state is changed. 
	/// - Parameter cstate: The new state of the call 
	/// - Parameter message: An informational message about the state. 
	/// 
	open func onStateChanged(call: Call, cstate: Call.State, message: String) {}
	///	Callback for notifying progresses of transfers. 
	/// - Parameter call: LinphoneCall that was transfered 
	/// - Parameter cstate: The state of the call to transfer target at the far end. 
	/// 
	open func onTransferStateChanged(call: Call, cstate: Call.State) {}
	///	Callback for notifying a received TMMBR. 
	/// - Parameter call: LinphoneCall for which the TMMBR has changed 
	/// - Parameter streamIndex: the index of the current stream 
	/// - Parameter tmmbr: the value of the received TMMBR 
	/// 
	open func onTmmbrReceived(call: Call, streamIndex: Int, tmmbr: Int) {}
	///	Callback for receiving info messages. 
	/// - Parameter call: LinphoneCall whose info message belongs to. 
	/// - Parameter msg: LinphoneInfoMessage object. 
	/// 
	open func onInfoMessageReceived(call: Call, msg: InfoMessage) {}
	///	Call encryption changed callback. 
	/// - Parameter call: LinphoneCall object whose encryption is changed. 
	/// - Parameter on: Whether encryption is activated. 
	/// - Parameter authenticationToken: An authentication_token, currently set for
	/// ZRTP kind of encryption only. 
	/// 
	open func onEncryptionChanged(call: Call, on: Bool, authenticationToken: String) {}
	///	Callback for notifying the processing SIP ACK messages. 
	/// - Parameter call: LinphoneCall for which an ACK is being received or sent 
	/// - Parameter ack: the ACK message 
	/// - Parameter isReceived: if true this ACK is an incoming one, otherwise it is an
	/// ACK about to be sent. 
	/// 
	open func onAckProcessing(call: Call, ack: Headers, isReceived: Bool) {}
	///	Callback for being notified of received DTMFs. 
	/// - Parameter call: LinphoneCall object that received the dtmf 
	/// - Parameter dtmf: The ascii code of the dtmf 
	/// 
	open func onDtmfReceived(call: Call, dtmf: Int) {}
	///	Callback to notify a next video frame has been decoded. 
	/// - Parameter call: LinphoneCall for which the next video frame has been decoded 
	/// 
	open func onNextVideoFrameDecoded(call: Call) {}
	///	Callback for receiving quality statistics for calls. 
	/// - Parameter call: LinphoneCall object whose statistics are notified 
	/// - Parameter stats: LinphoneCallStats object 
	/// 
	open func onStatsUpdated(call: Call, stats: CallStats) {}
}

open class ChatMessageDelegate : LinphoneObjectDelegate
{
	var cPtr: OpaquePointer

	public init() {
		self.cPtr = linphone_factory_create_chat_message_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)

		linphone_chat_message_cbs_set_participant_imdn_state_changed(cPtr, { (msg, state) -> Void in
			if (msg != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: msg!)
				let delegate = sObject.currentCallbacks
				delegate?.onParticipantImdnStateChanged(msg: sObject, state: ParticipantImdnState.getSwiftObject(cObject: state!))
			}
		})

		linphone_chat_message_cbs_set_file_transfer_recv(cPtr, { (msg, content, buffer) -> Void in
			if (msg != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: msg!)
				let delegate = sObject.currentCallbacks
				delegate?.onFileTransferRecv(msg: sObject, content: Content.getSwiftObject(cObject: content!), buffer: Buffer.getSwiftObject(cObject: buffer!))
			}
		})

		linphone_chat_message_cbs_set_msg_state_changed(cPtr, { (msg, state) -> Void in
			if (msg != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: msg!)
				let delegate = sObject.currentCallbacks
				delegate?.onMsgStateChanged(msg: sObject, state: ChatMessage.State(rawValue: Int(state.rawValue))!)
			}
		})

		linphone_chat_message_cbs_set_file_transfer_send(cPtr, { (msg, content, offset, size) -> OpaquePointer? in
			if (msg != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: msg!)
				let delegate = sObject.currentCallbacks
				return delegate?.onFileTransferSend(msg: sObject, content: Content.getSwiftObject(cObject: content!), offset: Int(offset), size: Int(size))?.cPtr
			} else {
				return nil
			}
		})

		linphone_chat_message_cbs_set_ephemeral_message_timer_started(cPtr, { (msg) -> Void in
			if (msg != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: msg!)
				let delegate = sObject.currentCallbacks
				delegate?.onEphemeralMessageTimerStarted(msg: sObject)
			}
		})

		linphone_chat_message_cbs_set_file_transfer_progress_indication(cPtr, { (msg, content, offset, total) -> Void in
			if (msg != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: msg!)
				let delegate = sObject.currentCallbacks
				delegate?.onFileTransferProgressIndication(msg: sObject, content: Content.getSwiftObject(cObject: content!), offset: Int(offset), total: Int(total))
			}
		})

		linphone_chat_message_cbs_set_file_transfer_send_chunk(cPtr, { (message, content, offset, size, buffer) -> Void in
			if (message != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: message!)
				let delegate = sObject.currentCallbacks
				delegate?.onFileTransferSendChunk(message: sObject, content: Content.getSwiftObject(cObject: content!), offset: Int(offset), size: Int(size), buffer: Buffer.getSwiftObject(cObject: buffer!))
			}
		})

		linphone_chat_message_cbs_set_ephemeral_message_deleted(cPtr, { (msg) -> Void in
			if (msg != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: msg!)
				let delegate = sObject.currentCallbacks
				delegate?.onEphemeralMessageDeleted(msg: sObject)
			}
		})
	}

	deinit {
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  nil, nil)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPtr))
	}

	///	Call back used to notify participant IMDN state. 
	/// - Parameter msg: LinphoneChatMessage object 
	/// - Parameter state: LinphoneParticipantImdnState 
	/// 
	open func onParticipantImdnStateChanged(msg: ChatMessage, state: ParticipantImdnState) {}
	///	File transfer receive callback prototype. 
	/// This function is called by the core upon an incoming File transfer is started.
	/// This function may be call several time for the same file in case of large file. 
	/// 
	/// - Parameter msg: LinphoneChatMessage message from which the body is received. 
	/// - Parameter content: LinphoneContent incoming content information 
	/// - Parameter buffer: LinphoneBuffer holding the received data. Empty buffer
	/// means end of file. 
	/// 
	open func onFileTransferRecv(msg: ChatMessage, content: Content, buffer: Buffer) {}
	///	Call back used to notify message delivery status. 
	/// - Parameter msg: LinphoneChatMessage object 
	/// 
	open func onMsgStateChanged(msg: ChatMessage, state: ChatMessage.State) {}
	///	File transfer send callback prototype. 
	/// This function is called by the core when an outgoing file transfer is started.
	/// This function is called until size is set to 0. 
	/// 
	/// - Parameter msg: LinphoneChatMessage message from which the body is received. 
	/// - Parameter content: LinphoneContent outgoing content 
	/// - Parameter offset: the offset in the file from where to get the data to be
	/// sent 
	/// - Parameter size: the number of bytes expected by the framework 
	/// 
	/// 
	/// - Returns: A LinphoneBuffer object holding the data written by the application.
	/// An empty buffer means end of file. 
	/// 
	/// - Warning: The returned value isn't used, hence the deprecation! 
	/// 
	/// - deprecated: 17/08/2020 Use LinphoneChatMessageCbsFileTransferSendChunkCb
	/// instead. 
	open func onFileTransferSend(msg: ChatMessage, content: Content, offset: Int, size: Int) -> Buffer? {return nil}
	///	Callback used to notify an ephemeral message that its lifespan before
	///	disappearing has started to decrease. 
	/// This callback is called when the ephemeral message is read by the receiver. 
	/// 
	/// - Parameter msg: LinphoneChatMessage object 
	/// 
	open func onEphemeralMessageTimerStarted(msg: ChatMessage) {}
	///	File transfer progress indication callback prototype. 
	/// - Parameter msg: LinphoneChatMessage message from which the body is received. 
	/// - Parameter content: LinphoneContent incoming content information 
	/// - Parameter offset: The number of bytes sent/received since the beginning of
	/// the transfer. 
	/// - Parameter total: The total number of bytes to be sent/received. 
	/// 
	open func onFileTransferProgressIndication(msg: ChatMessage, content: Content, offset: Int, total: Int) {}
	///	File transfer send callback prototype. 
	/// This function is called by the core when an outgoing file transfer is started.
	/// This function is called until size is set to 0. 
	/// 
	/// - Parameter message: LinphoneChatMessage message from which the body is
	/// received. @notnil 
	/// - Parameter content: LinphoneContent outgoing content @notnil 
	/// - Parameter offset: the offset in the file from where to get the data to be
	/// sent 
	/// - Parameter size: the number of bytes expected by the framework 
	/// - Parameter buffer: A LinphoneBuffer to be filled. Leave it empty when end of
	/// file has been reached. @notnil 
	/// 
	open func onFileTransferSendChunk(message: ChatMessage, content: Content, offset: Int, size: Int, buffer: Buffer) {}
	///	Call back used to notify ephemeral message is deleted. 
	/// - Parameter msg: LinphoneChatMessage object 
	/// 
	open func onEphemeralMessageDeleted(msg: ChatMessage) {}
}

open class ChatRoomDelegate : LinphoneObjectDelegate
{
	var cPtr: OpaquePointer

	public init() {
		self.cPtr = linphone_factory_create_chat_room_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)

		linphone_chat_room_cbs_set_state_changed(cPtr, { (cr, newState) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onStateChanged(cr: sObject, newState: ChatRoom.State(rawValue: Int(newState.rawValue))!)
			}
		})

		linphone_chat_room_cbs_set_participant_registration_unsubscription_requested(cPtr, { (cr, participantAddr) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onParticipantRegistrationUnsubscriptionRequested(cr: sObject, participantAddr: Address.getSwiftObject(cObject: participantAddr!))
			}
		})

		linphone_chat_room_cbs_set_participant_admin_status_changed(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onParticipantAdminStatusChanged(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_participant_removed(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onParticipantRemoved(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_ephemeral_message_timer_started(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onEphemeralMessageTimerStarted(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_undecryptable_message_received(cPtr, { (cr, msg) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onUndecryptableMessageReceived(cr: sObject, msg: ChatMessage.getSwiftObject(cObject: msg!))
			}
		})

		linphone_chat_room_cbs_set_participant_added(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onParticipantAdded(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_ephemeral_event(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onEphemeralEvent(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_chat_message_received(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onChatMessageReceived(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_conference_address_generation(cPtr, { (cr) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onConferenceAddressGeneration(cr: sObject)
			}
		})

		linphone_chat_room_cbs_set_participant_device_added(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onParticipantDeviceAdded(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_security_event(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onSecurityEvent(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_conference_left(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onConferenceLeft(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_subject_changed(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onSubjectChanged(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_chat_message_sent(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onChatMessageSent(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_conference_joined(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onConferenceJoined(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_message_received(cPtr, { (cr, msg) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onMessageReceived(cr: sObject, msg: ChatMessage.getSwiftObject(cObject: msg!))
			}
		})

		linphone_chat_room_cbs_set_ephemeral_message_deleted(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onEphemeralMessageDeleted(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_participant_registration_subscription_requested(cPtr, { (cr, participantAddr) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onParticipantRegistrationSubscriptionRequested(cr: sObject, participantAddr: Address.getSwiftObject(cObject: participantAddr!))
			}
		})

		linphone_chat_room_cbs_set_participant_device_removed(cPtr, { (cr, eventLog) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onParticipantDeviceRemoved(cr: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_is_composing_received(cPtr, { (cr, remoteAddr, isComposing) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onIsComposingReceived(cr: sObject, remoteAddr: Address.getSwiftObject(cObject: remoteAddr!), isComposing: isComposing != 0)
			}
		})

		linphone_chat_room_cbs_set_chat_message_should_be_stored(cPtr, { (cr, msg) -> Void in
			if (cr != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: cr!)
				let delegate = sObject.currentCallbacks
				delegate?.onChatMessageShouldBeStored(cr: sObject, msg: ChatMessage.getSwiftObject(cObject: msg!))
			}
		})
	}

	deinit {
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  nil, nil)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPtr))
	}

	///	Callback used to notify a chat room state has changed. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter newState: The new state of the chat room 
	/// 
	open func onStateChanged(cr: ChatRoom, newState: ChatRoom.State) {}
	///	Callback used when a group chat room server is unsubscribing to registration
	///	state of a participant. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter participantAddr: LinphoneAddress object 
	/// 
	open func onParticipantRegistrationUnsubscriptionRequested(cr: ChatRoom, participantAddr: Address) {}
	///	Callback used to notify a chat room that the admin status of a participant has
	///	been changed. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter eventLog: LinphoneEventLog The event to be notified 
	/// 
	open func onParticipantAdminStatusChanged(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used to notify a chat room that a participant has been removed. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter eventLog: LinphoneEventLog The event to be notified 
	/// 
	open func onParticipantRemoved(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used to notify a chat room that the lifespan of an ephemeral message
	///	before disappearing has started to decrease. 
	/// This callback is called when the ephemeral message is read by the receiver. 
	/// 
	/// - Parameter cr: LinphoneChatRoom object 
	/// 
	open func onEphemeralMessageTimerStarted(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used to notify a chat room that a message has been received but we
	///	were unable to decrypt it. 
	/// - Parameter cr: LinphoneChatRoom involved in this conversation 
	/// - Parameter msg: The LinphoneChatMessage that has been received 
	/// 
	open func onUndecryptableMessageReceived(cr: ChatRoom, msg: ChatMessage) {}
	///	Callback used to notify a chat room that a participant has been added. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter eventLog: LinphoneEventLog The event to be notified 
	/// 
	open func onParticipantAdded(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used to notify a chat room that an ephemeral related event has been
	///	generated. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// 
	open func onEphemeralEvent(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used to notify a chat room that a chat message has been received. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter eventLog: LinphoneEventLog The event to be notified 
	/// 
	open func onChatMessageReceived(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used when a group chat room is created server-side to generate the
	///	address of the chat room. 
	/// The function linphone_chat_room_set_conference_address needs to be called by
	/// this callback. 
	/// 
	/// - Parameter cr: LinphoneChatRoom object 
	/// 
	open func onConferenceAddressGeneration(cr: ChatRoom) {}
	///	Callback used to notify a chat room that a participant has been added. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter eventLog: LinphoneEventLog The event to be notified 
	/// 
	open func onParticipantDeviceAdded(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used to notify a security event in the chat room. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter eventLog: LinphoneEventLog The event to be notified 
	/// 
	open func onSecurityEvent(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used to notify a chat room has been left. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// 
	open func onConferenceLeft(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used to notify that the subject of a chat room has changed. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter eventLog: LinphoneEventLog The event to be notified 
	/// 
	open func onSubjectChanged(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used to notify a chat room that a chat message is being sent. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter eventLog: LinphoneEventLog The event to be notified 
	/// 
	open func onChatMessageSent(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used to notify a chat room has been joined. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// 
	open func onConferenceJoined(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used to notify a chat room that a message has been received. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter msg: The LinphoneChatMessage that has been received 
	/// 
	open func onMessageReceived(cr: ChatRoom, msg: ChatMessage) {}
	///	Callback used to notify a chat room that an ephemeral message has been deleted. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// 
	open func onEphemeralMessageDeleted(cr: ChatRoom, eventLog: EventLog) {}
	///	Callback used when a group chat room server is subscribing to registration
	///	state of a participant. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter participantAddr: LinphoneAddress object 
	/// 
	open func onParticipantRegistrationSubscriptionRequested(cr: ChatRoom, participantAddr: Address) {}
	///	Callback used to notify a chat room that a participant has been removed. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter eventLog: LinphoneEventLog The event to be notified 
	/// 
	open func onParticipantDeviceRemoved(cr: ChatRoom, eventLog: EventLog) {}
	///	Is composing notification callback prototype. 
	/// - Parameter cr: LinphoneChatRoom involved in the conversation 
	/// - Parameter remoteAddr: The address that has sent the is-composing notification 
	/// - Parameter isComposing: A boolean value telling whether the remote is
	/// composing or not 
	/// 
	open func onIsComposingReceived(cr: ChatRoom, remoteAddr: Address, isComposing: Bool) {}
	///	Callback used to tell the core whether or not to store the incoming message in
	///	db or not using linphone_chat_message_set_to_be_stored. 
	/// - Parameter cr: LinphoneChatRoom object 
	/// - Parameter msg: The LinphoneChatMessage that is being received 
	/// 
	open func onChatMessageShouldBeStored(cr: ChatRoom, msg: ChatMessage) {}
}

open class CoreDelegate : LinphoneObjectDelegate
{
	var cPtr: OpaquePointer

	public init() {
		self.cPtr = linphone_factory_create_core_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)

		linphone_core_cbs_set_transfer_state_changed(cPtr, { (lc, transfered, newCallState) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onTransferStateChanged(lc: sObject, transfered: Call.getSwiftObject(cObject: transfered!), newCallState: Call.State(rawValue: Int(newCallState.rawValue))!)
			}
		})

		linphone_core_cbs_set_friend_list_created(cPtr, { (lc, list) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onFriendListCreated(lc: sObject, list: FriendList.getSwiftObject(cObject: list!))
			}
		})

		linphone_core_cbs_set_subscription_state_changed(cPtr, { (lc, lev, state) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onSubscriptionStateChanged(lc: sObject, lev: Event.getSwiftObject(cObject: lev!), state: SubscriptionState(rawValue: Int(state.rawValue))!)
			}
		})

		linphone_core_cbs_set_call_log_updated(cPtr, { (lc, newcl) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onCallLogUpdated(lc: sObject, newcl: CallLog.getSwiftObject(cObject: newcl!))
			}
		})

		linphone_core_cbs_set_call_state_changed(cPtr, { (lc, call, cstate, message) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onCallStateChanged(lc: sObject, call: Call.getSwiftObject(cObject: call!), cstate: Call.State(rawValue: Int(cstate.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})

		linphone_core_cbs_set_authentication_requested(cPtr, { (lc, authInfo, method) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onAuthenticationRequested(lc: sObject, authInfo: AuthInfo.getSwiftObject(cObject: authInfo!), method: AuthMethod(rawValue: Int(method.rawValue))!)
			}
		})

		linphone_core_cbs_set_notify_presence_received_for_uri_or_tel(cPtr, { (lc, lf, uriOrTel, presenceModel) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onNotifyPresenceReceivedForUriOrTel(lc: sObject, lf: Friend.getSwiftObject(cObject: lf!), uriOrTel: charArrayToString(charPointer: uriOrTel), presenceModel: PresenceModel.getSwiftObject(cObject: presenceModel!))
			}
		})

		linphone_core_cbs_set_chat_room_state_changed(cPtr, { (lc, cr, state) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onChatRoomStateChanged(lc: sObject, cr: ChatRoom.getSwiftObject(cObject: cr!), state: ChatRoom.State(rawValue: Int(state.rawValue))!)
			}
		})

		linphone_core_cbs_set_buddy_info_updated(cPtr, { (lc, lf) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onBuddyInfoUpdated(lc: sObject, lf: Friend.getSwiftObject(cObject: lf!))
			}
		})

		linphone_core_cbs_set_network_reachable(cPtr, { (lc, reachable) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onNetworkReachable(lc: sObject, reachable: reachable != 0)
			}
		})

		linphone_core_cbs_set_notify_received(cPtr, { (lc, lev, notifiedEvent, body) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onNotifyReceived(lc: sObject, lev: Event.getSwiftObject(cObject: lev!), notifiedEvent: charArrayToString(charPointer: notifiedEvent), body: Content.getSwiftObject(cObject: body!))
			}
		})

		linphone_core_cbs_set_new_subscription_requested(cPtr, { (lc, lf, url) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onNewSubscriptionRequested(lc: sObject, lf: Friend.getSwiftObject(cObject: lf!), url: charArrayToString(charPointer: url))
			}
		})

		linphone_core_cbs_set_call_stats_updated(cPtr, { (lc, call, stats) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onCallStatsUpdated(lc: sObject, call: Call.getSwiftObject(cObject: call!), stats: CallStats.getSwiftObject(cObject: stats!))
			}
		})

		linphone_core_cbs_set_notify_presence_received(cPtr, { (lc, lf) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onNotifyPresenceReceived(lc: sObject, lf: Friend.getSwiftObject(cObject: lf!))
			}
		})

		linphone_core_cbs_set_ec_calibration_audio_init(cPtr, { (lc) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onEcCalibrationAudioInit(lc: sObject)
			}
		})

		linphone_core_cbs_set_message_received(cPtr, { (lc, room, message) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onMessageReceived(lc: sObject, room: ChatRoom.getSwiftObject(cObject: room!), message: ChatMessage.getSwiftObject(cObject: message!))
			}
		})

		linphone_core_cbs_set_ec_calibration_result(cPtr, { (lc, status, delayMs) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onEcCalibrationResult(lc: sObject, status: EcCalibratorStatus(rawValue: Int(status.rawValue))!, delayMs: Int(delayMs))
			}
		})

		linphone_core_cbs_set_subscribe_received(cPtr, { (lc, lev, subscribeEvent, body) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onSubscribeReceived(lc: sObject, lev: Event.getSwiftObject(cObject: lev!), subscribeEvent: charArrayToString(charPointer: subscribeEvent), body: Content.getSwiftObject(cObject: body!))
			}
		})

		linphone_core_cbs_set_info_received(cPtr, { (lc, call, msg) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onInfoReceived(lc: sObject, call: Call.getSwiftObject(cObject: call!), msg: InfoMessage.getSwiftObject(cObject: msg!))
			}
		})

		linphone_core_cbs_set_chat_room_read(cPtr, { (lc, room) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onChatRoomRead(lc: sObject, room: ChatRoom.getSwiftObject(cObject: room!))
			}
		})

		linphone_core_cbs_set_registration_state_changed(cPtr, { (lc, cfg, cstate, message) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onRegistrationStateChanged(lc: sObject, cfg: ProxyConfig.getSwiftObject(cObject: cfg!), cstate: RegistrationState(rawValue: Int(cstate.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})

		linphone_core_cbs_set_friend_list_removed(cPtr, { (lc, list) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onFriendListRemoved(lc: sObject, list: FriendList.getSwiftObject(cObject: list!))
			}
		})

		linphone_core_cbs_set_refer_received(cPtr, { (lc, referTo) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onReferReceived(lc: sObject, referTo: charArrayToString(charPointer: referTo))
			}
		})

		linphone_core_cbs_set_qrcode_found(cPtr, { (lc, result) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onQrcodeFound(lc: sObject, result: charArrayToString(charPointer: result))
			}
		})

		linphone_core_cbs_set_configuring_status(cPtr, { (lc, status, message) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onConfiguringStatus(lc: sObject, status: ConfiguringState(rawValue: Int(status.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})

		linphone_core_cbs_set_call_created(cPtr, { (lc, call) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onCallCreated(lc: sObject, call: Call.getSwiftObject(cObject: call!))
			}
		})

		linphone_core_cbs_set_publish_state_changed(cPtr, { (lc, lev, state) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onPublishStateChanged(lc: sObject, lev: Event.getSwiftObject(cObject: lev!), state: PublishState(rawValue: Int(state.rawValue))!)
			}
		})

		linphone_core_cbs_set_call_encryption_changed(cPtr, { (lc, call, on, authenticationToken) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onCallEncryptionChanged(lc: sObject, call: Call.getSwiftObject(cObject: call!), on: on != 0, authenticationToken: charArrayToString(charPointer: authenticationToken))
			}
		})

		linphone_core_cbs_set_is_composing_received(cPtr, { (lc, room) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onIsComposingReceived(lc: sObject, room: ChatRoom.getSwiftObject(cObject: room!))
			}
		})

		linphone_core_cbs_set_message_received_unable_decrypt(cPtr, { (lc, room, message) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onMessageReceivedUnableDecrypt(lc: sObject, room: ChatRoom.getSwiftObject(cObject: room!), message: ChatMessage.getSwiftObject(cObject: message!))
			}
		})

		linphone_core_cbs_set_log_collection_upload_progress_indication(cPtr, { (lc, offset, total) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onLogCollectionUploadProgressIndication(lc: sObject, offset: Int(offset), total: Int(total))
			}
		})

		linphone_core_cbs_set_chat_room_subject_changed(cPtr, { (lc, cr) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onChatRoomSubjectChanged(lc: sObject, cr: ChatRoom.getSwiftObject(cObject: cr!))
			}
		})

		linphone_core_cbs_set_version_update_check_result_received(cPtr, { (lc, result, version, url) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onVersionUpdateCheckResultReceived(lc: sObject, result: VersionUpdateCheckResult(rawValue: Int(result.rawValue))!, version: charArrayToString(charPointer: version), url: charArrayToString(charPointer: url))
			}
		})

		linphone_core_cbs_set_ec_calibration_audio_uninit(cPtr, { (lc) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onEcCalibrationAudioUninit(lc: sObject)
			}
		})

		linphone_core_cbs_set_global_state_changed(cPtr, { (lc, gstate, message) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onGlobalStateChanged(lc: sObject, gstate: GlobalState(rawValue: Int(gstate.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})

		linphone_core_cbs_set_log_collection_upload_state_changed(cPtr, { (lc, state, info) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onLogCollectionUploadStateChanged(lc: sObject, state: Core.LogCollectionUploadState(rawValue: Int(state.rawValue))!, info: charArrayToString(charPointer: info))
			}
		})

		linphone_core_cbs_set_dtmf_received(cPtr, { (lc, call, dtmf) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onDtmfReceived(lc: sObject, call: Call.getSwiftObject(cObject: call!), dtmf: Int(dtmf))
			}
		})

		linphone_core_cbs_set_chat_room_ephemeral_message_deleted(cPtr, { (lc, cr) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onChatRoomEphemeralMessageDeleted(lc: sObject, cr: ChatRoom.getSwiftObject(cObject: cr!))
			}
		})

		linphone_core_cbs_set_message_sent(cPtr, { (lc, room, message) -> Void in
			if (lc != nil) {
				let sObject = Core.getSwiftObject(cObject: lc!)
				let delegate = sObject.currentCallbacks
				delegate?.onMessageSent(lc: sObject, room: ChatRoom.getSwiftObject(cObject: room!), message: ChatMessage.getSwiftObject(cObject: message!))
			}
		})
	}

	deinit {
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  nil, nil)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPtr))
	}

	///	Callback for notifying progresses of transfers. 
	/// - Parameter lc: the LinphoneCore 
	/// - Parameter transfered: the call that was transfered 
	/// - Parameter newCallState: the state of the call to transfer target at the far
	/// end. 
	/// 
	open func onTransferStateChanged(lc: Core, transfered: Call, newCallState: Call.State) {}
	///	Callback prototype for reporting when a friend list has been added to the core
	///	friends list. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter list: LinphoneFriendList object 
	/// 
	open func onFriendListCreated(lc: Core, list: FriendList) {}
	///	Callback prototype for notifying the application about changes of subscription
	///	states, including arrival of new subscriptions. 
	open func onSubscriptionStateChanged(lc: Core, lev: Event, state: SubscriptionState) {}
	///	Callback to notify a new call-log entry has been added. 
	/// This is done typically when a call terminates. 
	/// 
	/// - Parameter lc: the LinphoneCore 
	/// - Parameter newcl: the new call log entry added. 
	/// 
	open func onCallLogUpdated(lc: Core, newcl: CallLog) {}
	///	Call state notification callback. 
	/// - Parameter lc: the LinphoneCore 
	/// - Parameter call: the call object whose state is changed. 
	/// - Parameter cstate: the new state of the call 
	/// - Parameter message: a non nil informational message about the state. 
	/// 
	open func onCallStateChanged(lc: Core, call: Call, cstate: Call.State, message: String) {}
	///	Callback for requesting authentication information to application or user. 
	/// - Parameter lc: the LinphoneCore 
	/// - Parameter authInfo: a LinphoneAuthInfo pre-filled with username, realm and
	/// domain values as much as possible 
	/// - Parameter method: the type of authentication requested Application shall
	/// reply to this callback using linphone_core_add_auth_info. 
	/// 
	open func onAuthenticationRequested(lc: Core, authInfo: AuthInfo, method: AuthMethod) {}
	///	Reports presence model change for a specific URI or phone number of a friend. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter lf: LinphoneFriend object 
	/// - Parameter uriOrTel: The URI or phone number for which teh presence model has
	/// changed 
	/// - Parameter presenceModel: The new presence model 
	/// 
	open func onNotifyPresenceReceivedForUriOrTel(lc: Core, lf: Friend, uriOrTel: String, presenceModel: PresenceModel) {}
	///	Callback prototype telling that a LinphoneChatRoom state has changed. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter cr: The LinphoneChatRoom object for which the state has changed 
	/// 
	open func onChatRoomStateChanged(lc: Core, cr: ChatRoom, state: ChatRoom.State) {}
	///	Callback prototype. 
	open func onBuddyInfoUpdated(lc: Core, lf: Friend) {}
	///	Callback prototype for reporting network change either automatically detected
	///	or notified by linphone_core_set_network_reachable. 
	/// - Parameter lc: the LinphoneCore 
	/// - Parameter reachable: true if network is reachable. 
	/// 
	open func onNetworkReachable(lc: Core, reachable: Bool) {}
	///	Callback prototype for notifying the application about notification received
	///	from the network. 
	open func onNotifyReceived(lc: Core, lev: Event, notifiedEvent: String, body: Content) {}
	///	Reports that a new subscription request has been received and wait for a
	///	decision. 
	/// Status on this subscription request is notified by changing policy  for this
	/// friend 
	/// 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter lf: LinphoneFriend corresponding to the subscriber 
	/// - Parameter url: of the subscriber 
	/// 
	open func onNewSubscriptionRequested(lc: Core, lf: Friend, url: String) {}
	///	Callback for receiving quality statistics for calls. 
	/// - Parameter lc: the LinphoneCore 
	/// - Parameter call: the call 
	/// - Parameter stats: the call statistics. 
	/// 
	open func onCallStatsUpdated(lc: Core, call: Call, stats: CallStats) {}
	///	Report status change for a friend previously added  to LinphoneCore. 
	/// - Parameter lc: LinphoneCore object . 
	/// - Parameter lf: Updated LinphoneFriend . 
	/// 
	open func onNotifyPresenceReceived(lc: Core, lf: Friend) {}
	///	Function prototype used by #linphone_core_cbs_set_ec_calibrator_audio_init(). 
	/// - Parameter lc: The core. 
	/// 
	open func onEcCalibrationAudioInit(lc: Core) {}
	///	Chat message callback prototype. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter room: LinphoneChatRoom involved in this conversation. Can be be
	/// created by the framework in case the from  is not present in any chat room. 
	/// 
	open func onMessageReceived(lc: Core, room: ChatRoom, message: ChatMessage) {}
	///	Function prototype used by #linphone_core_cbs_set_ec_calibrator_result(). 
	/// - Parameter lc: The core. 
	/// - Parameter status: The state of the calibrator. 
	/// - Parameter delayMs: The measured delay if available. 
	/// 
	open func onEcCalibrationResult(lc: Core, status: EcCalibratorStatus, delayMs: Int) {}
	///	Callback prototype for notifying the application about subscription received
	///	from the network. 
	open func onSubscribeReceived(lc: Core, lev: Event, subscribeEvent: String, body: Content) {}
	///	Callback prototype for receiving info messages. 
	/// - Parameter lc: the LinphoneCore 
	/// - Parameter call: the call whose info message belongs to. 
	/// - Parameter msg: the info message. 
	/// 
	open func onInfoReceived(lc: Core, call: Call, msg: InfoMessage) {}
	///	Chat room marked as read callback. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter room: LinphoneChatRoom that has been marked as read. 
	/// 
	open func onChatRoomRead(lc: Core, room: ChatRoom) {}
	///	Registration state notification callback prototype. 
	open func onRegistrationStateChanged(lc: Core, cfg: ProxyConfig, cstate: RegistrationState, message: String) {}
	///	Callback prototype for reporting when a friend list has been removed from the
	///	core friends list. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter list: LinphoneFriendList object 
	/// 
	open func onFriendListRemoved(lc: Core, list: FriendList) {}
	///	Callback prototype. 
	open func onReferReceived(lc: Core, referTo: String) {}
	///	Callback prototype telling the result of decoded qrcode. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter result: The result of the decoded qrcode 
	/// 
	open func onQrcodeFound(lc: Core, result: String) {}
	///	Callback prototype for configuring status changes notification. 
	/// - Parameter lc: the LinphoneCore 
	/// - Parameter message: informational message. 
	/// 
	open func onConfiguringStatus(lc: Core, status: ConfiguringState, message: String) {}
	///	Callback notifying that a new LinphoneCall (either incoming or outgoing) has
	///	been created. 
	/// - Parameter lc: LinphoneCore object that has created the call 
	/// - Parameter call: The newly created LinphoneCall object 
	/// 
	open func onCallCreated(lc: Core, call: Call) {}
	///	Callback prototype for notifying the application about changes of publish
	///	states. 
	open func onPublishStateChanged(lc: Core, lev: Event, state: PublishState) {}
	///	Call encryption changed callback. 
	/// - Parameter lc: the LinphoneCore 
	/// - Parameter call: the call on which encryption is changed. 
	/// - Parameter on: whether encryption is activated. 
	/// - Parameter authenticationToken: an authentication_token, currently set for
	/// ZRTP kind of encryption only. 
	/// 
	open func onCallEncryptionChanged(lc: Core, call: Call, on: Bool, authenticationToken: String) {}
	///	Is composing notification callback prototype. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter room: LinphoneChatRoom involved in the conversation. 
	/// 
	open func onIsComposingReceived(lc: Core, room: ChatRoom) {}
	///	Chat message not decrypted callback prototype. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter room: LinphoneChatRoom involved in this conversation. Can be be
	/// created by the framework in case the from  is not present in any chat room. 
	/// 
	open func onMessageReceivedUnableDecrypt(lc: Core, room: ChatRoom, message: ChatMessage) {}
	///	Callback prototype for reporting log collection upload progress indication. 
	/// - Parameter lc: LinphoneCore object 
	/// 
	open func onLogCollectionUploadProgressIndication(lc: Core, offset: Int, total: Int) {}
	///	Callback prototype telling that a LinphoneChatRoom subject has changed. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter cr: The LinphoneChatRoom object for which the subject has changed 
	/// 
	open func onChatRoomSubjectChanged(lc: Core, cr: ChatRoom) {}
	///	Callback prototype for reporting the result of a version update check. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter result: The result of the version update check 
	/// - Parameter url: The url where to download the new version if the result is
	/// #LinphoneVersionUpdateCheckNewVersionAvailable 
	/// 
	open func onVersionUpdateCheckResultReceived(lc: Core, result: VersionUpdateCheckResult, version: String, url: String) {}
	///	Function prototype used by #linphone_core_cbs_set_ec_calibrator_audio_uninit(). 
	/// - Parameter lc: The core. 
	/// 
	open func onEcCalibrationAudioUninit(lc: Core) {}
	///	Global state notification callback. 
	/// - Parameter lc: the LinphoneCore. 
	/// - Parameter gstate: the global state 
	/// - Parameter message: informational message. 
	/// 
	open func onGlobalStateChanged(lc: Core, gstate: GlobalState, message: String) {}
	///	Callback prototype for reporting log collection upload state change. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter state: The state of the log collection upload 
	/// - Parameter info: Additional information: error message in case of error state,
	/// URL of uploaded file in case of success. 
	/// 
	open func onLogCollectionUploadStateChanged(lc: Core, state: Core.LogCollectionUploadState, info: String) {}
	///	Callback for being notified of DTMFs received. 
	/// - Parameter lc: the linphone core 
	/// - Parameter call: the call that received the dtmf 
	/// - Parameter dtmf: the ascii code of the dtmf 
	/// 
	open func onDtmfReceived(lc: Core, call: Call, dtmf: Int) {}
	///	Callback prototype telling that a LinphoneChatRoom ephemeral message has
	///	expired. 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter cr: The LinphoneChatRoom object for which a message has expired. 
	/// 
	open func onChatRoomEphemeralMessageDeleted(lc: Core, cr: ChatRoom) {}
	///	Called after the #send method of the LinphoneChatMessage was called. 
	/// The message will be in state InProgress. In case of resend this callback won't
	/// be called. 
	/// 
	/// - Parameter lc: LinphoneCore object 
	/// - Parameter room: LinphoneChatRoom involved in this conversation. Can be be
	/// created by the framework in case the from  is not present in any chat room. 
	/// 
	open func onMessageSent(lc: Core, room: ChatRoom, message: ChatMessage) {}
}

open class EventDelegate : LinphoneObjectDelegate
{
	var cPtr: OpaquePointer

	public init() {
		self.cPtr = linphone_factory_create_event_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)

		linphone_event_cbs_set_notify_response(cPtr, { (ev) -> Void in
			if (ev != nil) {
				let sObject = Event.getSwiftObject(cObject: ev!)
				let delegate = sObject.currentCallbacks
				delegate?.onNotifyResponse(ev: sObject)
			}
		})
	}

	deinit {
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  nil, nil)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPtr))
	}

	///	Callback used to notify the response to a sent NOTIFY. 
	/// - Parameter ev: The LinphoneEvent object that has sent the NOTIFY and for which
	/// we received a response 
	/// 
	open func onNotifyResponse(ev: Event) {}
}

open class FriendListDelegate : LinphoneObjectDelegate
{
	var cPtr: OpaquePointer

	public init() {
		self.cPtr = linphone_factory_create_friend_list_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)

		linphone_friend_list_cbs_set_contact_updated(cPtr, { (list, newFriend, oldFriend) -> Void in
			if (list != nil) {
				let sObject = FriendList.getSwiftObject(cObject: list!)
				let delegate = sObject.currentCallbacks
				delegate?.onContactUpdated(list: sObject, newFriend: Friend.getSwiftObject(cObject: newFriend!), oldFriend: Friend.getSwiftObject(cObject: oldFriend!))
			}
		})

		linphone_friend_list_cbs_set_presence_received(cPtr, { (list, friends) -> Void in
			if (list != nil) {
				let sObject = FriendList.getSwiftObject(cObject: list!)
				let delegate = sObject.currentCallbacks
				var friendssList = [Friend]()
				var friendscList = friends
				while (friendscList != nil) {
					let data = unsafeBitCast(friendscList!.pointee.data, to: OpaquePointer.self)
					friendssList.append(Friend.getSwiftObject(cObject: data))
					friendscList = UnsafePointer<bctbx_list_t>(friendscList!.pointee.next)
				}
				delegate?.onPresenceReceived(list: sObject, friends: friendssList)
			}
		})

		linphone_friend_list_cbs_set_sync_status_changed(cPtr, { (list, status, msg) -> Void in
			if (list != nil) {
				let sObject = FriendList.getSwiftObject(cObject: list!)
				let delegate = sObject.currentCallbacks
				delegate?.onSyncStatusChanged(list: sObject, status: FriendList.SyncStatus(rawValue: Int(status.rawValue))!, msg: charArrayToString(charPointer: msg))
			}
		})

		linphone_friend_list_cbs_set_contact_created(cPtr, { (list, lf) -> Void in
			if (list != nil) {
				let sObject = FriendList.getSwiftObject(cObject: list!)
				let delegate = sObject.currentCallbacks
				delegate?.onContactCreated(list: sObject, lf: Friend.getSwiftObject(cObject: lf!))
			}
		})

		linphone_friend_list_cbs_set_contact_deleted(cPtr, { (list, lf) -> Void in
			if (list != nil) {
				let sObject = FriendList.getSwiftObject(cObject: list!)
				let delegate = sObject.currentCallbacks
				delegate?.onContactDeleted(list: sObject, lf: Friend.getSwiftObject(cObject: lf!))
			}
		})
	}

	deinit {
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  nil, nil)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPtr))
	}

	///	Callback used to notify a contact has been updated on the CardDAV server. 
	/// - Parameter list: The LinphoneFriendList object in which a contact has been
	/// updated 
	/// - Parameter newFriend: The new LinphoneFriend object corresponding to the
	/// updated contact 
	/// - Parameter oldFriend: The old LinphoneFriend object before update 
	/// 
	open func onContactUpdated(list: FriendList, newFriend: Friend, oldFriend: Friend) {}
	///	Callback used to notify a list with all friends that have received presence
	///	information. 
	/// - Parameter list: The LinphoneFriendList object for which the status has
	/// changed 
	/// - Parameter friends: A A list of LinphoneFriend objects. LinphoneFriend  of the
	/// relevant friends 
	/// 
	open func onPresenceReceived(list: FriendList, friends: [Friend]) {}
	///	Callback used to notify the status of the synchronization has changed. 
	/// - Parameter list: The LinphoneFriendList object for which the status has
	/// changed 
	/// - Parameter status: The new synchronisation status 
	/// - Parameter msg: An additional information on the status update 
	/// 
	open func onSyncStatusChanged(list: FriendList, status: FriendList.SyncStatus, msg: String) {}
	///	Callback used to notify a new contact has been created on the CardDAV server
	///	and downloaded locally. 
	/// - Parameter list: The LinphoneFriendList object the new contact is added to 
	/// - Parameter lf: The LinphoneFriend object that has been created 
	/// 
	open func onContactCreated(list: FriendList, lf: Friend) {}
	///	Callback used to notify a contact has been deleted on the CardDAV server. 
	/// - Parameter list: The LinphoneFriendList object a contact has been removed from 
	/// - Parameter lf: The LinphoneFriend object that has been deleted 
	/// 
	open func onContactDeleted(list: FriendList, lf: Friend) {}
}

open class LoggingServiceDelegate : LinphoneObjectDelegate
{
	var cPtr: OpaquePointer

	public init() {
		self.cPtr = linphone_factory_create_logging_service_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)

		linphone_logging_service_cbs_set_log_message_written(cPtr, { (logService, domain, lev, message) -> Void in
			if (logService != nil) {
				let sObject = LoggingService.getSwiftObject(cObject: logService!)
				let delegate = sObject.currentCallbacks
				delegate?.onLogMessageWritten(logService: sObject, domain: charArrayToString(charPointer: domain), lev: LogLevel(rawValue: Int(lev.rawValue)), message: charArrayToString(charPointer: message))
			}
		})
	}

	deinit {
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  nil, nil)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPtr))
	}

	///	Type of callbacks called each time liblinphone write a log message. 
	/// - Parameter logService: A pointer on the logging service singleton. 
	/// - Parameter domain: A string describing which sub-library of liblinphone the
	/// message is coming from. 
	/// - Parameter lev: Verbosity level of the message. 
	/// - Parameter message: Content of the message. 
	/// 
	open func onLogMessageWritten(logService: LoggingService, domain: String, lev: LogLevel, message: String) {}
}

open class PlayerDelegate : LinphoneObjectDelegate
{
	var cPtr: OpaquePointer

	public init() {
		self.cPtr = linphone_factory_create_player_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)

		linphone_player_cbs_set_eof_reached(cPtr, { (obj) -> Void in
			if (obj != nil) {
				let sObject = Player.getSwiftObject(cObject: obj!)
				let delegate = sObject.currentCallbacks
				delegate?.onEofReached(obj: sObject)
			}
		})
	}

	deinit {
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  nil, nil)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPtr))
	}

	///	Callback for notifying end of play (file). 
	open func onEofReached(obj: Player) {}
}

open class XmlRpcRequestDelegate : LinphoneObjectDelegate
{
	var cPtr: OpaquePointer

	public init() {
		self.cPtr = linphone_factory_create_xml_rpc_request_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)

		linphone_xml_rpc_request_cbs_set_response(cPtr, { (request) -> Void in
			if (request != nil) {
				let sObject = XmlRpcRequest.getSwiftObject(cObject: request!)
				let delegate = sObject.currentCallbacks
				delegate?.onResponse(request: sObject)
			}
		})
	}

	deinit {
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  nil, nil)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPtr))
	}

	///	Callback used to notify the response to an XML-RPC request. 
	/// - Parameter request: LinphoneXmlRpcRequest object 
	/// 
	open func onResponse(request: XmlRpcRequest) {}
}


/// The `AccountCreator` object used to configure an account on a server via
/// XML-RPC. 
public class AccountCreator : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> AccountCreator {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<AccountCreator>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = AccountCreator(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	///Enum describing the status of server request. 
	public enum Status:Int
	{
		/// Request status. 
		case RequestOk = 0
		/// Request failed. 
		case RequestFailed = 1
		/// Request failed due to missing argument(s) 
		case MissingArguments = 2
		/// Request failed due to missing callback(s) 
		case MissingCallbacks = 3
		/// Account status. 
		case AccountCreated = 4
		/// Account not created. 
		case AccountNotCreated = 5
		/// Account exist. 
		case AccountExist = 6
		/// Account exist with alias. 
		case AccountExistWithAlias = 7
		/// Account not exist. 
		case AccountNotExist = 8
		/// Account was created with Alias. 
		case AliasIsAccount = 9
		/// Alias exist. 
		case AliasExist = 10
		/// Alias not exist. 
		case AliasNotExist = 11
		/// Account activated. 
		case AccountActivated = 12
		/// Account already activated. 
		case AccountAlreadyActivated = 13
		/// Account not activated. 
		case AccountNotActivated = 14
		/// Account linked. 
		case AccountLinked = 15
		/// Account not linked. 
		case AccountNotLinked = 16
		/// Server. 
		case ServerError = 17
		/// Error cannot send SMS. 
		case PhoneNumberInvalid = 18
		/// Error key doesn't match. 
		case WrongActivationCode = 19
		/// Error too many SMS sent. 
		case PhoneNumberOverused = 20
		case AlgoNotSupported = 21
		/// < Error algo isn't MD5 or SHA-256 
		case UnexpectedError = 22
	}

	///Enum describing Transport checking. 
	public enum TransportStatus:Int
	{
		/// Transport ok. 
		case Ok = 0
		/// Transport invalid. 
		case Unsupported = 1
	}

	///Enum describing Domain checking. 
	public enum DomainStatus:Int
	{
		/// Domain ok. 
		case Ok = 0
		/// Domain invalid. 
		case Invalid = 1
	}

	///Enum describing Activation code checking. 
	public enum ActivationCodeStatus:Int
	{
		/// Activation code ok. 
		case Ok = 0
		/// Activation code too short. 
		case TooShort = 1
		/// Activation code too long. 
		case TooLong = 2
		/// Contain invalid characters. 
		case InvalidCharacters = 3
	}

	///Enum describing language checking. 
	public enum LanguageStatus:Int
	{
		/// Language ok. 
		case Ok = 0
	}

	///Enum describing Password checking. 
	public enum PasswordStatus:Int
	{
		/// Password ok. 
		case Ok = 0
		/// Password too short. 
		case TooShort = 1
		/// Password too long. 
		case TooLong = 2
		/// Contain invalid characters. 
		case InvalidCharacters = 3
		/// Missing specific characters. 
		case MissingCharacters = 4
	}

	///Enum describing Email checking. 
	public enum EmailStatus:Int
	{
		/// Email ok. 
		case Ok = 0
		/// Email malformed. 
		case Malformed = 1
		/// Contain invalid characters. 
		case InvalidCharacters = 2
	}

	///Enum describing Username checking. 
	public enum UsernameStatus:Int
	{
		/// Username ok. 
		case Ok = 0
		/// Username too short. 
		case TooShort = 1
		/// Username too long. 
		case TooLong = 2
		/// Contain invalid characters. 
		case InvalidCharacters = 3
		/// Invalid username. 
		case Invalid = 4
	}

	///Enum describing Phone number checking. 
	public enum PhoneNumberStatus:Int
	{
		/// Phone number ok. 
		case Ok = 1
		/// Phone number too short. 
		case TooShort = 2
		/// Phone number too long. 
		case TooLong = 4
		/// Country code invalid. 
		case InvalidCountryCode = 8
		/// Phone number invalid. 
		case Invalid = 16
	}
	public func getDelegate() -> AccountCreatorDelegate?
	{
		let cObject = linphone_account_creator_get_callbacks(cPtr)
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<AccountCreatorDelegate>.fromOpaque(result!).takeUnretainedValue()
			}
		return nil
	}
	public func addDelegate(delegate: AccountCreatorDelegate)
	{
		linphone_account_creator_add_callbacks(cPtr, delegate.cPtr)
	}
	public func removeDelegate(delegate: AccountCreatorDelegate)
	{
		linphone_account_creator_remove_callbacks(cPtr, delegate.cPtr)
	}

	/// Get the activation code. 
	/// - Returns: The activation code of the `AccountCreator` 
	public var activationCode: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_account_creator_get_activation_code(cPtr))
		}
		set
		{
			linphone_account_creator_set_activation_code(cPtr, newValue)
		}
	}

	/// Get the algorithm configured in the account creator. 
	/// - Returns: The algorithm of the `AccountCreator` 
	public var algorithm: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_account_creator_get_algorithm(cPtr))
		}
		set
		{
			linphone_account_creator_set_algorithm(cPtr, newValue)
		}
	}

	/// Set the set_as_default property. 
	/// - Parameter setAsDefault: The set_as_default to set 
	/// 
	/// 
	/// - Returns: LinphoneAccountCreatorStatusRequestOk if everything is OK, or a
	/// specific error otherwise. 
	public var asDefault: Bool?
	{
		willSet
		{
			linphone_account_creator_set_as_default(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the current LinphoneAccountCreatorCbs object associated with a
	/// LinphoneAccountCreator. 
	/// - Returns: The current LinphoneAccountCreatorCbs object associated with the
	/// LinphoneAccountCreator. 
	public var currentCallbacks: AccountCreatorDelegate?
	{
			let cObject = linphone_account_creator_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<AccountCreatorDelegate>.fromOpaque(result!).takeUnretainedValue()
				}
			return nil
	}

	/// Get the display name. 
	/// - Returns: The display name of the `AccountCreator` 
	public var displayName: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_account_creator_get_display_name(cPtr))
		}
		set
		{
			linphone_account_creator_set_display_name(cPtr, newValue)
		}
	}

	/// Get the domain. 
	/// - Returns: The domain of the `AccountCreator` 
	public var domain: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_account_creator_get_domain(cPtr))
		}
		set
		{
			linphone_account_creator_set_domain(cPtr, newValue)
		}
	}

	/// Get the email. 
	/// - Returns: The email of the `AccountCreator` 
	public var email: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_account_creator_get_email(cPtr))
		}
		set
		{
			linphone_account_creator_set_email(cPtr, newValue)
		}
	}

	/// Get the ha1. 
	/// - Returns: The ha1 of the `AccountCreator` 
	public var ha1: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_account_creator_get_ha1(cPtr))
		}
		set
		{
			linphone_account_creator_set_ha1(cPtr, newValue)
		}
	}

	/// Get the language use in email of SMS. 
	/// - Returns: The language of the `AccountCreator` 
	public var language: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_account_creator_get_language(cPtr))
		}
		set
		{
			linphone_account_creator_set_language(cPtr, newValue)
		}
	}

	/// Get the password. 
	/// - Returns: The password of the `AccountCreator` 
	public var password: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_account_creator_get_password(cPtr))
		}
		set
		{
			linphone_account_creator_set_password(cPtr, newValue)
		}
	}

	/// Get the RFC 3966 normalized phone number. 
	/// - Returns: The phone number of the `AccountCreator` 
	public var phoneNumber: String
	{
			return charArrayToString(charPointer: linphone_account_creator_get_phone_number(cPtr))
	}

	/// Assign a proxy config pointer to the LinphoneAccountCreator. 
	/// - Parameter cfg: The LinphoneProxyConfig to associate with the
	/// LinphoneAccountCreator. 
	/// 
	public var proxyConfig: ProxyConfig?
	{
		willSet
		{
			linphone_account_creator_set_proxy_config(cPtr, newValue?.cPtr)
		}
	}

	/// Get the set_as_default property. 
	/// - Returns: The set_as_default of the `AccountCreator` 
	public var setAsDefault: Bool
	{
			return linphone_account_creator_get_set_as_default(cPtr) != 0
	}

	/// get Transport 
	/// - Returns: The transport of `AccountCreator` 
	public var transport: TransportType
	{
		get
		{
			return TransportType(rawValue: Int(linphone_account_creator_get_transport(cPtr).rawValue))!
		}
		set
		{
			linphone_account_creator_set_transport(cPtr, LinphoneTransportType(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Retrieve the user pointer associated with the LinphoneAccountCreator. 
	/// - Returns: The user pointer associated with the LinphoneAccountCreator. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_account_creator_get_user_data(cPtr)
		}
		set
		{
			linphone_account_creator_set_user_data(cPtr, newValue)
		}
	}

	/// Get the username. 
	/// - Returns: The username of the `AccountCreator` 
	public var username: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_account_creator_get_username(cPtr))
		}
		set
		{
			linphone_account_creator_set_username(cPtr, newValue)
		}
	}
	///	Send a request to activate an account on server. 
	/// - Returns: LinphoneAccountCreatorStatusRequestOk if the request has been sent,
	/// LinphoneAccountCreatorStatusRequestFailed otherwise 
	public func activateAccount() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_activate_account(cPtr).rawValue))!
	}
	///	Send a request to activate an alias. 
	/// - Returns: LinphoneAccountCreatorStatusRequestOk if the request has been sent,
	/// LinphoneAccountCreatorStatusRequestFailed otherwise 
	public func activateAlias() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_activate_alias(cPtr).rawValue))!
	}
	///	Send a request to create an account on server. 
	/// - Returns: LinphoneAccountCreatorStatusRequestOk if the request has been sent,
	/// LinphoneAccountCreatorStatusRequestFailed otherwise 
	public func createAccount() throws -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_create_account(cPtr).rawValue))!
	}
	///	Create and configure a proxy config and a authentication info for an account
	///	creator. 
	/// - Returns: A `ProxyConfig` object if successful, nil otherwise 
	public func createProxyConfig() throws -> ProxyConfig
	{
		let cPointer = linphone_account_creator_create_proxy_config(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ProxyConfig value")
		}
		return ProxyConfig.getSwiftObject(cObject: cPointer!)
	}
	///	Send a request to know if an account is activated on server. 
	/// - Returns: LinphoneAccountCreatorStatusRequestOk if the request has been sent,
	/// LinphoneAccountCreatorStatusRequestFailed otherwise 
	public func isAccountActivated() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_is_account_activated(cPtr).rawValue))!
	}
	///	Send a request to know the existence of account on server. 
	/// - Returns: LinphoneAccountCreatorStatusRequestOk if the request has been sent,
	/// LinphoneAccountCreatorStatusRequestFailed otherwise 
	public func isAccountExist() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_is_account_exist(cPtr).rawValue))!
	}
	///	Send a request to know if an account is linked. 
	/// - Returns: LinphoneAccountCreatorStatusRequestOk if the request has been sent,
	/// LinphoneAccountCreatorStatusRequestFailed otherwise 
	public func isAccountLinked() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_is_account_linked(cPtr).rawValue))!
	}
	///	Send a request to know if an alias is used. 
	/// - Returns: LinphoneAccountCreatorStatusRequestOk if the request has been sent,
	/// LinphoneAccountCreatorStatusRequestFailed otherwise 
	public func isAliasUsed() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_is_alias_used(cPtr).rawValue))!
	}
	///	Send a request to link an account to an alias. 
	/// - Returns: LinphoneAccountCreatorStatusRequestOk if the request has been sent,
	/// LinphoneAccountCreatorStatusRequestFailed otherwise 
	public func linkAccount() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_link_account(cPtr).rawValue))!
	}
	///	Send a request to get the password & algorithm of an account using the
	///	confirmation key. 
	/// - Returns: LinphoneAccountCreatorStatusRequestOk if everything is OK, or a
	/// specific error otherwise. 
	public func loginLinphoneAccount() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_login_linphone_account(cPtr).rawValue))!
	}
	///	Send a request to recover an account. 
	/// - Returns: LinphoneAccountCreatorStatusRequestOk if the request has been sent,
	/// LinphoneAccountCreatorStatusRequestFailed otherwise 
	public func recoverAccount() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_recover_account(cPtr).rawValue))!
	}
	///	Reset the account creator entries like username, password, phone number... 
	public func reset() 
	{
		linphone_account_creator_reset(cPtr)
	}
	///	Set the phone number normalized. 
	/// - Parameter phoneNumber: The phone number to set 
	/// - Parameter countryCode: Country code to associate phone number with 
	/// 
	/// 
	/// - Returns: LinphoneAccountCreatorPhoneNumberStatusOk if everything is OK, or
	/// specific(s) error(s) otherwise. 
	public func setPhoneNumber(phoneNumber:String, countryCode:String) -> UInt
	{
		return UInt(linphone_account_creator_set_phone_number(cPtr, phoneNumber, countryCode))
	}
	///	Send a request to update an account. 
	/// - Returns: LinphoneAccountCreatorStatusRequestOk if the request has been sent,
	/// LinphoneAccountCreatorStatusRequestFailed otherwise 
	public func updateAccount() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_update_account(cPtr).rawValue))!
	}
}

/// Object that represents a SIP address. 
/// The `Address` is an opaque object to represents SIP addresses, ie the content
/// of SIP's 'from' and 'to' headers. A SIP address is made of display name,
/// username, domain name, port, and various uri headers (such as tags). It looks
/// like 'Alice <sip:alice@example.net>'. The `Address` has methods to extract and
/// manipulate all parts of the address. When some part of the address (for example
/// the username) is empty, the accessor methods return nil. 
public class Address : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Address {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Address>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Address(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Returns the display name. 
	public var displayName: String
	{
			return charArrayToString(charPointer: linphone_address_get_display_name(cPtr))
	}

	public func setDisplayname(newValue: String) throws
	{
		let exception_result = linphone_address_set_display_name(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns the domain name. 
	public var domain: String
	{
			return charArrayToString(charPointer: linphone_address_get_domain(cPtr))
	}

	public func setDomain(newValue: String) throws
	{
		let exception_result = linphone_address_set_domain(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// returns true if address is a routable sip address 
	public var isSip: Bool
	{
			return linphone_address_is_sip(cPtr) != 0
	}

	/// Get the value of the method parameter. 
	public var methodParam: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_address_get_method_param(cPtr))
		}
		set
		{
			linphone_address_set_method_param(cPtr, newValue)
		}
	}

	/// Get the password encoded in the address. 
	/// It is used for basic authentication (not recommended). 
	/// 
	/// - Returns: the password, if any, nil otherwise. 
	public var password: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_address_get_password(cPtr))
		}
		set
		{
			linphone_address_set_password(cPtr, newValue)
		}
	}

	/// Get port number as an integer value, 0 if not present. 
	public var port: Int
	{
			return Int(linphone_address_get_port(cPtr))
	}

	public func setPort(newValue: Int) throws
	{
		let exception_result = linphone_address_set_port(cPtr, CInt(newValue))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns the address scheme, normally "sip". 
	public var scheme: String
	{
			return charArrayToString(charPointer: linphone_address_get_scheme(cPtr))
	}

	/// Returns true if address refers to a secure location (sips) 
	public var secure: Bool
	{
		get
		{
			return linphone_address_get_secure(cPtr) != 0
		}
		set
		{
			linphone_address_set_secure(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the transport. 
	public var transport: TransportType
	{
			return TransportType(rawValue: Int(linphone_address_get_transport(cPtr).rawValue))!
	}

	public func setTransport(newValue: TransportType) throws
	{
		let exception_result = linphone_address_set_transport(cPtr, LinphoneTransportType(rawValue: CUnsignedInt(newValue.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns the username. 
	public var username: String
	{
			return charArrayToString(charPointer: linphone_address_get_username(cPtr))
	}

	public func setUsername(newValue: String) throws
	{
		let exception_result = linphone_address_set_username(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}
	///	Returns the address as a string. 
	/// The returned char * must be freed by the application. Use ms_free(). 
	public func asString() -> String
	{
		return charArrayToString(charPointer: linphone_address_as_string(cPtr))
	}
	///	Returns the SIP uri only as a string, that is display name is removed. 
	/// The returned char * must be freed by the application. Use ms_free(). 
	public func asStringUriOnly() -> String
	{
		return charArrayToString(charPointer: linphone_address_as_string_uri_only(cPtr))
	}
	///	Removes address's tags and uri headers so that it is displayable to the user. 
	public func clean() 
	{
		linphone_address_clean(cPtr)
	}
	///	Clones a `Address` object. 
	public func clone() -> Address?
	{
		let cPointer = linphone_address_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		return Address.getSwiftObject(cObject: cPointer!)
	}
	///	Compare two `Address` taking the tags and headers into account. 
	/// - Parameter address2: `Address` object 
	/// 
	/// 
	/// - Returns: Boolean value telling if the `Address` objects are equal. 
	/// 
	/// - See also: {@link Address#weakEqual} 
	public func equal(address2:Address) -> Bool
	{
		return linphone_address_equal(cPtr, address2.cPtr) != 0
	}
	///	Get the header encoded in the address. 
	/// - Parameter headerName: the header name 
	/// 
	public func getHeader(headerName:String) -> String
	{
		return charArrayToString(charPointer: linphone_address_get_header(cPtr, headerName))
	}
	///	Get the value of a parameter of the address. 
	/// - Parameter paramName: The name of the parameter 
	/// 
	/// 
	/// - Returns: The value of the parameter 
	public func getParam(paramName:String) -> String
	{
		return charArrayToString(charPointer: linphone_address_get_param(cPtr, paramName))
	}
	///	Get the value of a parameter of the URI of the address. 
	/// - Parameter uriParamName: The name of the parameter 
	/// 
	/// 
	/// - Returns: The value of the parameter 
	public func getUriParam(uriParamName:String) -> String
	{
		return charArrayToString(charPointer: linphone_address_get_uri_param(cPtr, uriParamName))
	}
	///	Tell whether a parameter is present in the address. 
	/// - Parameter paramName: The name of the parameter 
	/// 
	/// 
	/// - Returns: A boolean value telling whether the parameter is present in the
	/// address 
	public func hasParam(paramName:String) -> Bool
	{
		return linphone_address_has_param(cPtr, paramName) != 0
	}
	///	Tell whether a parameter is present in the URI of the address. 
	/// - Parameter uriParamName: The name of the parameter 
	/// 
	/// 
	/// - Returns: A boolean value telling whether the parameter is present in the URI
	/// of the address 
	public func hasUriParam(uriParamName:String) -> Bool
	{
		return linphone_address_has_uri_param(cPtr, uriParamName) != 0
	}
	///	Removes the value of a parameter of the URI of the address. 
	/// - Parameter uriParamName: The name of the parameter 
	/// 
	public func removeUriParam(uriParamName:String) 
	{
		linphone_address_remove_uri_param(cPtr, uriParamName)
	}
	///	Set a header into the address. 
	/// Headers appear in the URI with '?', such as
	/// <sip:test@linphone.org?SomeHeader=SomeValue>. 
	/// 
	/// - Parameter headerName: the header name 
	/// - Parameter headerValue: the header value 
	/// 
	public func setHeader(headerName:String, headerValue:String) 
	{
		linphone_address_set_header(cPtr, headerName, headerValue)
	}
	///	Set the value of a parameter of the address. 
	/// - Parameter paramName: The name of the parameter 
	/// - Parameter paramValue: The new value of the parameter 
	/// 
	public func setParam(paramName:String, paramValue:String) 
	{
		linphone_address_set_param(cPtr, paramName, paramValue)
	}
	///	Set the value of a parameter of the URI of the address. 
	/// - Parameter uriParamName: The name of the parameter 
	/// - Parameter uriParamValue: The new value of the parameter 
	/// 
	public func setUriParam(uriParamName:String, uriParamValue:String) 
	{
		linphone_address_set_uri_param(cPtr, uriParamName, uriParamValue)
	}
	///	Compare two `Address` ignoring tags and headers, basically just domain,
	///	username, and port. 
	/// - Parameter address2: `Address` object 
	/// 
	/// 
	/// - Returns: Boolean value telling if the `Address` objects are equal. 
	/// 
	/// - See also: {@link Address#equal} 
	public func weakEqual(address2:Address) -> Bool
	{
		return linphone_address_weak_equal(cPtr, address2.cPtr) != 0
	}
}

/// Object holding authentication information. 
/// - Note: The object's fields should not be accessed directly. Prefer using the
/// accessor methods.
/// 
/// In most case, authentication information consists of a username and password.
/// Sometimes, a userid is required by proxy, and realm can be useful to
/// discriminate different SIP domains.
/// 
/// Once created and filled, a `AuthInfo` must be added to the `Core` in order to
/// become known and used automatically when needed. Use {@link Core#addAuthInfo}
/// for that purpose.
/// 
/// The `Core` object can take the initiative to request authentication information
/// when needed to the application through the auth_info_requested callback of the
/// LinphoneCoreVTable structure.
/// 
/// The application can respond to this information request later using {@link
/// Core#addAuthInfo}. This will unblock all pending authentication transactions
/// and retry them with authentication headers. 
public class AuthInfo : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> AuthInfo {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<AuthInfo>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = AuthInfo(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Gets the algorithm. 
	/// - Returns: The algorithm. 
	public var algorithm: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_auth_info_get_algorithm(cPtr))
		}
		set
		{
			linphone_auth_info_set_algorithm(cPtr, newValue)
		}
	}

	/// Gets the domain. 
	/// - Returns: The domain. 
	public var domain: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_auth_info_get_domain(cPtr))
		}
		set
		{
			linphone_auth_info_set_domain(cPtr, newValue)
		}
	}

	/// Gets the ha1. 
	/// - Returns: The ha1. 
	public var ha1: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_auth_info_get_ha1(cPtr))
		}
		set
		{
			linphone_auth_info_set_ha1(cPtr, newValue)
		}
	}

	/// Gets the password. 
	/// - Returns: The password. 
	/// 
	/// - deprecated: , use linphone_auth_info_get_password instead 
	public var passwd: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_auth_info_get_passwd(cPtr))
		}
		set
		{
			linphone_auth_info_set_passwd(cPtr, newValue)
		}
	}

	/// Gets the password. 
	/// - Returns: The password. 
	public var password: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_auth_info_get_password(cPtr))
		}
		set
		{
			linphone_auth_info_set_password(cPtr, newValue)
		}
	}

	/// Gets the realm. 
	/// - Returns: The realm. 
	public var realm: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_auth_info_get_realm(cPtr))
		}
		set
		{
			linphone_auth_info_set_realm(cPtr, newValue)
		}
	}

	/// Gets the TLS certificate. 
	/// - Returns: The TLS certificate. 
	public var tlsCert: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_auth_info_get_tls_cert(cPtr))
		}
		set
		{
			linphone_auth_info_set_tls_cert(cPtr, newValue)
		}
	}

	/// Gets the TLS certificate path. 
	/// - Returns: The TLS certificate path. 
	public var tlsCertPath: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_auth_info_get_tls_cert_path(cPtr))
		}
		set
		{
			linphone_auth_info_set_tls_cert_path(cPtr, newValue)
		}
	}

	/// Gets the TLS key. 
	/// - Returns: The TLS key. 
	public var tlsKey: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_auth_info_get_tls_key(cPtr))
		}
		set
		{
			linphone_auth_info_set_tls_key(cPtr, newValue)
		}
	}

	/// Gets the TLS key path. 
	/// - Returns: The TLS key path. 
	public var tlsKeyPath: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_auth_info_get_tls_key_path(cPtr))
		}
		set
		{
			linphone_auth_info_set_tls_key_path(cPtr, newValue)
		}
	}

	/// Gets the userid. 
	/// - Returns: The userid. 
	public var userid: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_auth_info_get_userid(cPtr))
		}
		set
		{
			linphone_auth_info_set_userid(cPtr, newValue)
		}
	}

	/// Gets the username. 
	/// - Returns: The username. 
	public var username: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_auth_info_get_username(cPtr))
		}
		set
		{
			linphone_auth_info_set_username(cPtr, newValue)
		}
	}
	///	Instantiates a new auth info with values from source. 
	/// - Returns: The newly created `AuthInfo` object. 
	public func clone() -> AuthInfo?
	{
		let cPointer = linphone_auth_info_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		return AuthInfo.getSwiftObject(cObject: cPointer!)
	}
}

/// The `Content` object representing a data buffer. 
public class Buffer : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Buffer {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Buffer>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Buffer(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///	Create a new `Buffer` object from existing data. 
	/// - Parameter data: The initial data to store in the LinphoneBuffer. 
	/// - Parameter size: The size of the initial data to stroe in the LinphoneBuffer. 
	/// 
	/// 
	/// - Returns: A new `Buffer` object. 
	static public func newFromData(data:UnsafePointer<UInt8>, size:Int) -> Buffer?
	{
		let cPointer = linphone_buffer_new_from_data(data, size)
		if (cPointer == nil) {
			return nil
		}
		return Buffer.getSwiftObject(cObject: cPointer!)
	}
	///	Create a new `Buffer` object from a string. 
	/// - Parameter data: The initial string content of the LinphoneBuffer. 
	/// 
	/// 
	/// - Returns: A new `Buffer` object. 
	static public func newFromString(data:String) -> Buffer?
	{
		let cPointer = linphone_buffer_new_from_string(data)
		if (cPointer == nil) {
			return nil
		}
		return Buffer.getSwiftObject(cObject: cPointer!)
	}

	/// Get the content of the data buffer. 
	/// - Returns: The content of the data buffer. 
	public var content: UnsafePointer<UInt8>
	{
			return linphone_buffer_get_content(cPtr)
	}

	/// Tell whether the `Buffer` is empty. 
	/// - Returns: A boolean value telling whether the `Buffer` is empty or not. 
	public var isEmpty: Bool
	{
			return linphone_buffer_is_empty(cPtr) != 0
	}

	/// Get the size of the content of the data buffer. 
	/// - Returns: The size of the content of the data buffer. 
	public var size: Int
	{
		get
		{
			return Int(linphone_buffer_get_size(cPtr))
		}
		set
		{
			linphone_buffer_set_size(cPtr, (newValue))
		}
	}

	/// Get the string content of the data buffer. 
	/// - Returns: The string content of the data buffer. 
	public var stringContent: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_buffer_get_string_content(cPtr))
		}
		set
		{
			linphone_buffer_set_string_content(cPtr, newValue)
		}
	}

	/// Retrieve the user pointer associated with the buffer. 
	/// - Returns: The user pointer associated with the buffer. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_buffer_get_user_data(cPtr)
		}
		set
		{
			linphone_buffer_set_user_data(cPtr, newValue)
		}
	}
	///	Set the content of the data buffer. 
	/// - Parameter content: The content of the data buffer. 
	/// - Parameter size: The size of the content of the data buffer. 
	/// 
	public func setContent(content:UnsafePointer<UInt8>, size:Int) 
	{
		linphone_buffer_set_content(cPtr, content, size)
	}
}

/// The `Call` object represents a call issued or received by the `Core`. 
public class Call : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Call {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Call>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Call(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	///Enum representing the status of a call. 
	public enum Status:Int
	{
		/// The call was sucessful. 
		case Success = 0
		/// The call was aborted. 
		case Aborted = 1
		/// The call was missed (unanswered) 
		case Missed = 2
		/// The call was declined, either locally or by remote end. 
		case Declined = 3
		/// The call was aborted before being advertised to the application - for protocol
		/// reasons. 
		case EarlyAborted = 4
		/// The call was answered on another device. 
		case AcceptedElsewhere = 5
		/// The call was declined on another device. 
		case DeclinedElsewhere = 6
	}

	///Enum representing the direction of a call. 
	public enum Dir:Int
	{
		/// outgoing calls 
		case Outgoing = 0
		/// incoming calls 
		case Incoming = 1
	}

	///LinphoneCallState enum represents the different states a call can reach into. 
	public enum State:Int
	{
		/// Initial state. 
		case Idle = 0
		/// Incoming call received. 
		case IncomingReceived = 1
		/// Outgoing call initialized. 
		case OutgoingInit = 2
		/// Outgoing call in progress. 
		case OutgoingProgress = 3
		/// Outgoing call ringing. 
		case OutgoingRinging = 4
		/// Outgoing call early media. 
		case OutgoingEarlyMedia = 5
		/// Connected. 
		case Connected = 6
		/// Streams running. 
		case StreamsRunning = 7
		/// Pausing. 
		case Pausing = 8
		/// Paused. 
		case Paused = 9
		/// Resuming. 
		case Resuming = 10
		/// Referred. 
		case Referred = 11
		/// Error. 
		case Error = 12
		/// Call end. 
		case End = 13
		/// Paused by remote. 
		case PausedByRemote = 14
		/// The call's parameters are updated for example when video is asked by remote. 
		case UpdatedByRemote = 15
		/// We are proposing early media to an incoming call. 
		case IncomingEarlyMedia = 16
		/// We have initiated a call update. 
		case Updating = 17
		/// The call object is now released. 
		case Released = 18
		/// The call is updated by remote while not yet answered (SIP UPDATE in early
		/// dialog received) 
		case EarlyUpdatedByRemote = 19
		/// We are updating the call while not yet answered (SIP UPDATE in early dialog
		/// sent) 
		case EarlyUpdating = 20
	}
	public func addDelegate(delegate: CallDelegate)
	{
		linphone_call_add_callbacks(cPtr, delegate.cPtr)
	}
	public func removeDelegate(delegate: CallDelegate)
	{
		linphone_call_remove_callbacks(cPtr, delegate.cPtr)
	}

	/// Returns the ZRTP authentication token to verify. 
	/// - Returns: the authentication token to verify. 
	public var authenticationToken: String
	{
			return charArrayToString(charPointer: linphone_call_get_authentication_token(cPtr))
	}

	/// Returns whether ZRTP authentication token is verified. 
	/// If not, it must be verified by users as described in ZRTP procedure. Once done,
	/// the application must inform of the results with {@link
	/// Call#setAuthenticationTokenVerified}. 
	/// 
	/// - Returns:  if authentication token is verifed, false otherwise. 
	public var authenticationTokenVerified: Bool
	{
		get
		{
			return linphone_call_get_authentication_token_verified(cPtr) != 0
		}
		set
		{
			linphone_call_set_authentication_token_verified(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns call quality averaged over all the duration of the call. 
	/// See {@link Call#getCurrentQuality} for more details about quality measurement. 
	public var averageQuality: Float
	{
			return linphone_call_get_average_quality(cPtr)
	}

	/// Gets the call log associated to this call. 
	/// - Returns: The `CallLog` associated with the specified `Call` 
	public var callLog: CallLog?
	{
			let cPointer = linphone_call_get_call_log(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return CallLog.getSwiftObject(cObject:cPointer!)
	}

	/// Returns true if camera pictures are allowed to be sent to the remote party. 
	public var cameraEnabled: Bool
	{
		get
		{
			return linphone_call_camera_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_enable_camera(cPtr, newValue==true ? 1:0)
		}
	}

	/// Create a new chat room for messaging from a call if not already existing, else
	/// return existing one. 
	/// No reference is given to the caller: the chat room will be deleted when the
	/// call is ended. 
	/// 
	/// - Returns: `ChatRoom` where messaging can take place. 
	public var chatRoom: ChatRoom?
	{
			let cPointer = linphone_call_get_chat_room(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ChatRoom.getSwiftObject(cObject:cPointer!)
	}

	/// Return the associated conference object. 
	/// - Returns: A pointer on `Conference` or nil if the call is not part of any
	/// conference. 
	public var conference: Conference?
	{
			let cPointer = linphone_call_get_conference(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Conference.getSwiftObject(cObject:cPointer!)
	}

	/// Get the core that has created the specified call. 
	/// - Returns: The `Core` object that has created the specified call. 
	public var core: Core?
	{
			let cPointer = linphone_call_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Core.getSwiftObject(cObject:cPointer!)
	}

	/// Gets the current LinphoneCallCbs. 
	/// This is meant only to be called from a callback to be able to get the user_data
	/// associated with the LinphoneCallCbs that is calling the callback. 
	/// 
	/// - Returns: The LinphoneCallCbs that has called the last callback 
	public var currentCallbacks: CallDelegate?
	{
			let cObject = linphone_call_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<CallDelegate>.fromOpaque(result!).takeUnretainedValue()
				}
			return nil
	}

	/// Returns current parameters associated to the call. 
	public var currentParams: CallParams?
	{
			let cPointer = linphone_call_get_current_params(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return CallParams.getSwiftObject(cObject:cPointer!)
	}

	/// Obtain real-time quality rating of the call. 
	/// Based on local RTP statistics and RTCP feedback, a quality rating is computed
	/// and updated during all the duration of the call. This function returns its
	/// value at the time of the function call. It is expected that the rating is
	/// updated at least every 5 seconds or so. The rating is a floating point number
	/// comprised between 0 and 5.
	/// 
	/// 4-5 = good quality  3-4 = average quality  2-3 = poor quality  1-2 = very poor
	/// quality  0-1 = can't be worse, mostly unusable 
	/// 
	/// - Returns: The function returns -1 if no quality measurement is available, for
	/// example if no active audio stream exist. Otherwise it returns the quality
	/// rating. 
	public var currentQuality: Float
	{
			return linphone_call_get_current_quality(cPtr)
	}

	/// Returns direction of the call (incoming or outgoing). 
	public var dir: Call.Dir
	{
			return Call.Dir(rawValue: Int(linphone_call_get_dir(cPtr).rawValue))!
	}

	/// Returns the diversion address associated to this call. 
	public var diversionAddress: Address?
	{
			let cPointer = linphone_call_get_diversion_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Returns call's duration in seconds. 
	public var duration: Int
	{
			return Int(linphone_call_get_duration(cPtr))
	}

	/// Returns true if echo cancellation is enabled. 
	public var echoCancellationEnabled: Bool
	{
		get
		{
			return linphone_call_echo_cancellation_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_enable_echo_cancellation(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns true if echo limiter is enabled. 
	public var echoLimiterEnabled: Bool
	{
		get
		{
			return linphone_call_echo_limiter_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_enable_echo_limiter(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns full details about call errors or termination reasons. 
	/// - Returns: `ErrorInfo` object holding the reason error. 
	public var errorInfo: ErrorInfo?
	{
			let cPointer = linphone_call_get_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ErrorInfo.getSwiftObject(cObject:cPointer!)
	}

	/// Returns whether or not the call is currently being recorded. 
	/// - Returns: true if recording is in progress, false otherwise 
	public var isRecording: Bool
	{
			return linphone_call_is_recording(cPtr) != 0
	}

	/// Get microphone muted state. 
	/// - Returns: The microphone muted state. 
	public var microphoneMuted: Bool
	{
		get
		{
			return linphone_call_get_microphone_muted(cPtr) != 0
		}
		set
		{
			linphone_call_set_microphone_muted(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get microphone volume gain. 
	/// If the sound backend supports it, the returned gain is equal to the gain set
	/// with the system mixer. 
	/// 
	/// - Returns: double Percentage of the max supported volume gain. Valid values are
	/// in [ 0.0 : 1.0 ]. In case of failure, a negative value is returned 
	public var microphoneVolumeGain: Float
	{
		get
		{
			return linphone_call_get_microphone_volume_gain(cPtr)
		}
		set
		{
			linphone_call_set_microphone_volume_gain(cPtr, newValue)
		}
	}

	/// Get the native window handle of the video window, casted as an unsigned long. 
	public var nativeVideoWindowId: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_call_get_native_video_window_id(cPtr)
		}
		set
		{
			linphone_call_set_native_video_window_id(cPtr, newValue)
		}
	}

	/// Returns local parameters associated with the call. 
	/// This is typically the parameters passed at call initiation to {@link
	/// Core#inviteAddressWithParams} or {@link Call#acceptWithParams}, or some default
	/// parameters if no `CallParams` was explicitely passed during call initiation. 
	/// 
	/// - Returns: the call's local parameters. 
	public var params: CallParams?
	{
		get
		{
			let cPointer = linphone_call_get_params(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return CallParams.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_call_set_params(cPtr, newValue?.cPtr)
		}
	}

	/// Get the mesured playback volume level (received from remote) in dbm0. 
	/// - Returns: float Volume level in percentage. 
	public var playVolume: Float
	{
			return linphone_call_get_play_volume(cPtr)
	}

	/// Get a player associated with the call to play a local file and stream it to the
	/// remote peer. 
	/// - Returns: A `Player` object 
	public var player: Player?
	{
			let cPointer = linphone_call_get_player(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Player.getSwiftObject(cObject:cPointer!)
	}

	/// Returns the reason for a call termination (either error or normal termination) 
	public var reason: Reason
	{
			return Reason(rawValue: Int(linphone_call_get_reason(cPtr).rawValue))!
	}

	/// Get the mesured record volume level (sent to remote) in dbm0. 
	/// - Returns: float Volume level in percentage. 
	public var recordVolume: Float
	{
			return linphone_call_get_record_volume(cPtr)
	}

	/// Gets the refer-to uri (if the call was transfered). 
	/// - Returns: The refer-to uri of the call (if it was transfered) 
	public var referTo: String
	{
			return charArrayToString(charPointer: linphone_call_get_refer_to(cPtr))
	}

	/// Returns the remote address associated to this call. 
	public var remoteAddress: Address?
	{
			let cPointer = linphone_call_get_remote_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Returns the remote address associated to this call as a string. 
	/// The result string must be freed by user using ms_free(). 
	public var remoteAddressAsString: String
	{
			return charArrayToString(charPointer: linphone_call_get_remote_address_as_string(cPtr))
	}

	/// Returns the far end's sip contact as a string, if available. 
	public var remoteContact: String
	{
			return charArrayToString(charPointer: linphone_call_get_remote_contact(cPtr))
	}

	/// Returns call parameters proposed by remote. 
	/// This is useful when receiving an incoming call, to know whether the remote
	/// party supports video, encryption or whatever. 
	public var remoteParams: CallParams?
	{
			let cPointer = linphone_call_get_remote_params(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return CallParams.getSwiftObject(cObject:cPointer!)
	}

	/// Returns the far end's user agent description string, if available. 
	public var remoteUserAgent: String
	{
			return charArrayToString(charPointer: linphone_call_get_remote_user_agent(cPtr))
	}

	/// Returns the call object this call is replacing, if any. 
	/// Call replacement can occur during call transfers. By default, the core
	/// automatically terminates the replaced call and accept the new one. This
	/// function allows the application to know whether a new incoming call is a one
	/// that replaces another one. 
	public var replacedCall: Call?
	{
			let cPointer = linphone_call_get_replaced_call(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Call.getSwiftObject(cObject:cPointer!)
	}

	/// Get speaker muted state. 
	/// - Returns: The speaker muted state. 
	public var speakerMuted: Bool
	{
		get
		{
			return linphone_call_get_speaker_muted(cPtr) != 0
		}
		set
		{
			linphone_call_set_speaker_muted(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get speaker volume gain. 
	/// If the sound backend supports it, the returned gain is equal to the gain set
	/// with the system mixer. 
	/// 
	/// - Returns: Percentage of the max supported volume gain. Valid values are in [
	/// 0.0 : 1.0 ]. In case of failure, a negative value is returned 
	public var speakerVolumeGain: Float
	{
		get
		{
			return linphone_call_get_speaker_volume_gain(cPtr)
		}
		set
		{
			linphone_call_set_speaker_volume_gain(cPtr, newValue)
		}
	}

	/// Retrieves the call's current state. 
	public var state: Call.State
	{
			return Call.State(rawValue: Int(linphone_call_get_state(cPtr).rawValue))!
	}

	/// Returns the number of stream for the given call. 
	/// Currently there is only two (Audio, Video), but later there will be more. 
	/// 
	/// - Returns: 2 
	public var streamCount: Int
	{
			return Int(linphone_call_get_stream_count(cPtr))
	}

	/// Returns the to address with its headers associated to this call. 
	public var toAddress: Address?
	{
			let cPointer = linphone_call_get_to_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Returns the current transfer state, if a transfer has been initiated from this
	/// call. 
	/// - See also: linphone_core_transfer_call ,
	/// linphone_core_transfer_call_to_another 
	public var transferState: Call.State
	{
			return Call.State(rawValue: Int(linphone_call_get_transfer_state(cPtr).rawValue))!
	}

	/// When this call has received a transfer request, returns the new call that was
	/// automatically created as a result of the transfer. 
	public var transferTargetCall: Call?
	{
			let cPointer = linphone_call_get_transfer_target_call(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Call.getSwiftObject(cObject:cPointer!)
	}

	/// Gets the transferer if this call was started automatically as a result of an
	/// incoming transfer request. 
	/// The call in which the transfer request was received is returned in this case. 
	/// 
	/// - Returns: The transferer call if the specified call was started automatically
	/// as a result of an incoming transfer request, nil otherwise 
	public var transfererCall: Call?
	{
			let cPointer = linphone_call_get_transferer_call(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Call.getSwiftObject(cObject:cPointer!)
	}

	/// Retrieve the user pointer associated with the call. 
	/// - Returns: The user pointer associated with the call. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_call_get_user_data(cPtr)
		}
		set
		{
			linphone_call_set_user_data(cPtr, newValue)
		}
	}
	///	Accept an incoming call. 
	/// Basically the application is notified of incoming calls within the
	/// call_state_changed callback of the LinphoneCoreVTable structure, where it will
	/// receive a LinphoneCallIncoming event with the associated `Call` object. The
	/// application can later accept the call using this method. 
	/// 
	/// - Returns: 0 on success, -1 on failure 
	public func accept() throws 
	{
		let exception_result = linphone_call_accept(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "accept returned value \(exception_result)")
		}
	}
	///	Accept an early media session for an incoming call. 
	/// This is identical as calling {@link Call#acceptEarlyMediaWithParams} with nil
	/// parameters. 
	/// 
	/// - Returns: 0 if successful, -1 otherwise 
	/// 
	/// - See also: {@link Call#acceptEarlyMediaWithParams} 
	public func acceptEarlyMedia() throws 
	{
		let exception_result = linphone_call_accept_early_media(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "acceptEarlyMedia returned value \(exception_result)")
		}
	}
	///	When receiving an incoming, accept to start a media session as early-media. 
	/// This means the call is not accepted but audio & video streams can be
	/// established if the remote party supports early media. However, unlike after
	/// call acceptance, mic and camera input are not sent during early-media, though
	/// received audio & video are played normally. The call can then later be fully
	/// accepted using {@link Call#accept} or {@link Call#acceptWithParams}. 
	/// 
	/// - Parameter params: The call parameters to use (can be nil)    
	/// 
	/// 
	/// - Returns: 0 if successful, -1 otherwise 
	public func acceptEarlyMediaWithParams(params:CallParams?) throws 
	{
		let exception_result = linphone_call_accept_early_media_with_params(cPtr, params?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "acceptEarlyMediaWithParams returned value \(exception_result)")
		}
	}
	///	Accept call modifications initiated by other end. 
	/// This call may be performed in response to a #LinphoneCallUpdatedByRemote state
	/// notification. When such notification arrives, the application can decide to
	/// call {@link Call#deferUpdate} so that it can have the time to prompt the user.
	/// {@link Call#getRemoteParams} can be used to get information about the call
	/// parameters requested by the other party, such as whether a video stream is
	/// requested.
	/// 
	/// When the user accepts or refuse the change, {@link Call#acceptUpdate} can be
	/// done to answer to the other party. If params is nil, then the same call
	/// parameters established before the update request will continue to be used (no
	/// change). If params is not nil, then the update will be accepted according to
	/// the parameters passed. Typical example is when a user accepts to start video,
	/// then params should indicate that video stream should be used (see {@link
	/// CallParams#enableVideo}). 
	/// 
	/// - Parameter params: A `CallParams` object describing the call parameters to
	/// accept    
	/// 
	/// 
	/// - Returns: 0 if successful, -1 otherwise (actually when this function call is
	/// performed outside ot #LinphoneCallUpdatedByRemote state) 
	public func acceptUpdate(params:CallParams?) throws 
	{
		let exception_result = linphone_call_accept_update(cPtr, params?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "acceptUpdate returned value \(exception_result)")
		}
	}
	///	Accept an incoming call, with parameters. 
	/// Basically the application is notified of incoming calls within the
	/// call_state_changed callback of the LinphoneCoreVTable structure, where it will
	/// receive a LinphoneCallIncoming event with the associated `Call` object. The
	/// application can later accept the call using this method. 
	/// 
	/// - Parameter params: The specific parameters for this call, for example whether
	/// video is accepted or not. Use nil to use default parameters    
	/// 
	/// 
	/// - Returns: 0 on success, -1 on failure 
	public func acceptWithParams(params:CallParams?) throws 
	{
		let exception_result = linphone_call_accept_with_params(cPtr, params?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "acceptWithParams returned value \(exception_result)")
		}
	}
	///	Tell whether a call has been asked to autoanswer. 
	/// - Returns: A boolean value telling whether the call has been asked to
	/// autoanswer 
	public func askedToAutoanswer() -> Bool
	{
		return linphone_call_asked_to_autoanswer(cPtr) != 0
	}
	///	Stop current DTMF sequence sending. 
	/// Please note that some DTMF could be already sent, depending on when this
	/// function call is delayed from linphone_call_send_dtmfs. This function will be
	/// automatically called if call state change to anything but
	/// LinphoneCallStreamsRunning. 
	public func cancelDtmfs() 
	{
		linphone_call_cancel_dtmfs(cPtr)
	}
	///	Decline a pending incoming call, with a reason. 
	/// - Parameter reason: The reason for rejecting the call: LinphoneReasonDeclined
	/// or LinphoneReasonBusy 
	/// 
	/// 
	/// - Returns: 0 on success, -1 on failure 
	public func decline(reason:Reason) throws 
	{
		let exception_result = linphone_call_decline(cPtr, LinphoneReason(rawValue: CUnsignedInt(reason.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "decline returned value \(exception_result)")
		}
	}
	///	Decline a pending incoming call, with a `ErrorInfo` object. 
	/// - Parameter ei: `ErrorInfo` containing more information on the call rejection. 
	/// 
	/// 
	/// - Returns: 0 on success, -1 on failure 
	public func declineWithErrorInfo(ei:ErrorInfo) -> Int
	{
		return Int(linphone_call_decline_with_error_info(cPtr, ei.cPtr))
	}
	///	When receiving a #LinphoneCallUpdatedByRemote state notification, prevent
	///	`Core` from performing an automatic answer. 
	/// When receiving a #LinphoneCallUpdatedByRemote state notification (ie an
	/// incoming reINVITE), the default behaviour of `Core` is defined by the
	/// "defer_update_default" option of the "sip" section of the config. If this
	/// option is 0 (the default) then the `Core` automatically answers the reINIVTE
	/// with call parameters unchanged. However when for example when the remote party
	/// updated the call to propose a video stream, it can be useful to prompt the user
	/// before answering. This can be achieved by calling
	/// linphone_core_defer_call_update during the call state notification, to
	/// deactivate the automatic answer that would just confirm the audio but reject
	/// the video. Then, when the user responds to dialog prompt, it becomes possible
	/// to call {@link Call#acceptUpdate} to answer the reINVITE, with eventually video
	/// enabled in the `CallParams` argument.
	/// 
	/// The #LinphoneCallUpdatedByRemote notification can also arrive when receiving an
	/// INVITE without SDP. In such case, an unchanged offer is made in the 200Ok, and
	/// when the ACK containing the SDP answer is received,
	/// #LinphoneCallUpdatedByRemote is triggered to notify the application of possible
	/// changes in the media session. However in such case defering the update has no
	/// meaning since we just generating an offer.
	/// 
	/// - Returns: 0 if successful, -1 if the {@link Call#deferUpdate} was done outside
	/// a valid #LinphoneCallUpdatedByRemote notification 
	public func deferUpdate() throws 
	{
		let exception_result = linphone_call_defer_update(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "deferUpdate returned value \(exception_result)")
		}
	}
	///	Return a copy of the call statistics for a particular stream type. 
	/// - Parameter type: the stream type 
	/// 
	public func getStats(type:StreamType) -> CallStats?
	{
		let cPointer = linphone_call_get_stats(cPtr, LinphoneStreamType(rawValue: CUnsignedInt(type.rawValue)))
		if (cPointer == nil) {
			return nil
		}
		return CallStats.getSwiftObject(cObject: cPointer!)
	}
	///	Returns the value of the header name. 
	public func getToHeader(name:String) -> String
	{
		return charArrayToString(charPointer: linphone_call_get_to_header(cPtr, name))
	}
	///	Returns true if this calls has received a transfer that has not been executed
	///	yet. 
	/// Pending transfers are executed when this call is being paused or closed,
	/// locally or by remote endpoint. If the call is already paused while receiving
	/// the transfer request, the transfer immediately occurs. 
	public func hasTransferPending() -> Bool
	{
		return linphone_call_has_transfer_pending(cPtr) != 0
	}
	///	Indicates whether an operation is in progress at the media side. 
	/// It can be a bad idea to initiate signaling operations (adding video, pausing
	/// the call, removing video, changing video parameters) while the media is busy in
	/// establishing the connection (typically ICE connectivity checks). It can result
	/// in failures generating loss of time in future operations in the call.
	/// Applications are invited to check this function after each call state change to
	/// decide whether certain operations are permitted or not. 
	/// 
	/// - Returns:  if media is busy in establishing the connection, true otherwise. 
	public func mediaInProgress() -> Bool
	{
		return linphone_call_media_in_progress(cPtr) != 0
	}
	///	Call generic OpenGL render for a given call. 
	public func oglRender() 
	{
		linphone_call_ogl_render(cPtr)
	}
	///	Pauses the call. 
	/// If a music file has been setup using {@link Core#setPlayFile}, this file will
	/// be played to the remote user. The only way to resume a paused call is to call
	/// {@link Call#resume}. 
	/// 
	/// - Returns: 0 on success, -1 on failure 
	/// 
	/// - See also: {@link Call#resume} 
	public func pause() throws 
	{
		let exception_result = linphone_call_pause(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "pause returned value \(exception_result)")
		}
	}
	///	Redirect the specified call to the given redirect URI. 
	/// - Parameter redirectUri: The URI to redirect the call to 
	/// 
	/// 
	/// - Returns: 0 if successful, -1 on error. 
	public func redirect(redirectUri:String) throws 
	{
		let exception_result = linphone_call_redirect(cPtr, redirectUri)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "redirect returned value \(exception_result)")
		}
	}
	///	Request the callback passed to linphone_call_cbs_set_next_video_frame_decoded
	///	to be called the next time the video decoder properly decodes a video frame. 
	public func requestNotifyNextVideoFrameDecoded() 
	{
		linphone_call_request_notify_next_video_frame_decoded(cPtr)
	}
	///	Resumes a call. 
	/// The call needs to have been paused previously with {@link Call#pause}. 
	/// 
	/// - Returns: 0 on success, -1 on failure 
	/// 
	/// - See also: {@link Call#pause} 
	public func resume() throws 
	{
		let exception_result = linphone_call_resume(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "resume returned value \(exception_result)")
		}
	}
	///	Send the specified dtmf. 
	/// The dtmf is automatically played to the user. 
	/// 
	/// - Parameter dtmf: The dtmf name specified as a char, such as '0', '#' etc... 
	/// 
	/// 
	/// - Returns: 0 if successful, -1 on error. 
	public func sendDtmf(dtmf:CChar) throws 
	{
		let exception_result = linphone_call_send_dtmf(cPtr, dtmf)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "sendDtmf returned value \(exception_result)")
		}
	}
	///	Send a list of dtmf. 
	/// The dtmfs are automatically sent to remote, separated by some needed
	/// customizable delay. Sending is canceled if the call state changes to something
	/// not LinphoneCallStreamsRunning. 
	/// 
	/// - Parameter dtmfs: A dtmf sequence such as '123#123123' 
	/// 
	/// 
	/// - Returns: -2 if there is already a DTMF sequence, -1 if call is not ready, 0
	/// otherwise. 
	public func sendDtmfs(dtmfs:String) throws 
	{
		let exception_result = linphone_call_send_dtmfs(cPtr, dtmfs)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "sendDtmfs returned value \(exception_result)")
		}
	}
	///	Send a `InfoMessage` through an established call. 
	/// - Parameter info: the info message 
	/// 
	public func sendInfoMessage(info:InfoMessage) throws 
	{
		let exception_result = linphone_call_send_info_message(cPtr, info.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "sendInfoMessage returned value \(exception_result)")
		}
	}
	///	Request remote side to send us a Video Fast Update. 
	public func sendVfuRequest() 
	{
		linphone_call_send_vfu_request(cPtr)
	}
	///	Start call recording. 
	/// Video record is only available if this function is called in state
	/// StreamRunning. The output file where audio is recorded must be previously
	/// specified with {@link CallParams#setRecordFile}. 
	public func startRecording() 
	{
		linphone_call_start_recording(cPtr)
	}
	///	Stop call recording. 
	public func stopRecording() 
	{
		linphone_call_stop_recording(cPtr)
	}
	///	Take a photo of currently captured video and write it into a jpeg file. 
	/// Note that the snapshot is asynchronous, an application shall not assume that
	/// the file is created when the function returns. 
	/// 
	/// - Parameter file: a path where to write the jpeg content. 
	/// 
	/// 
	/// - Returns: 0 if successfull, -1 otherwise (typically if jpeg format is not
	/// supported). 
	public func takePreviewSnapshot(file:String) throws 
	{
		let exception_result = linphone_call_take_preview_snapshot(cPtr, file)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "takePreviewSnapshot returned value \(exception_result)")
		}
	}
	///	Take a photo of currently received video and write it into a jpeg file. 
	/// Note that the snapshot is asynchronous, an application shall not assume that
	/// the file is created when the function returns. 
	/// 
	/// - Parameter file: a path where to write the jpeg content. 
	/// 
	/// 
	/// - Returns: 0 if successfull, -1 otherwise (typically if jpeg format is not
	/// supported). 
	public func takeVideoSnapshot(file:String) throws 
	{
		let exception_result = linphone_call_take_video_snapshot(cPtr, file)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "takeVideoSnapshot returned value \(exception_result)")
		}
	}
	///	Terminates a call. 
	/// - Returns: 0 on success, -1 on failure 
	public func terminate() throws 
	{
		let exception_result = linphone_call_terminate(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "terminate returned value \(exception_result)")
		}
	}
	///	Terminates a call. 
	/// - Parameter ei: `ErrorInfo` 
	/// 
	/// 
	/// - Returns: 0 on success, -1 on failure 
	public func terminateWithErrorInfo(ei:ErrorInfo) throws 
	{
		let exception_result = linphone_call_terminate_with_error_info(cPtr, ei.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "terminateWithErrorInfo returned value \(exception_result)")
		}
	}
	///	Performs a simple call transfer to the specified destination. 
	/// The remote endpoint is expected to issue a new call to the specified
	/// destination. The current call remains active and thus can be later paused or
	/// terminated. It is possible to follow the progress of the transfer provided that
	/// transferee sends notification about it. In this case, the
	/// transfer_state_changed callback of the LinphoneCoreVTable is invoked to notify
	/// of the state of the new call at the other party. The notified states are
	/// #LinphoneCallOutgoingInit , #LinphoneCallOutgoingProgress,
	/// #LinphoneCallOutgoingRinging and #LinphoneCallConnected. 
	/// 
	/// - Parameter referTo: The destination the call is to be refered to 
	/// 
	/// 
	/// - Returns: 0 on success, -1 on failure 
	public func transfer(referTo:String) throws 
	{
		let exception_result = linphone_call_transfer(cPtr, referTo)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "transfer returned value \(exception_result)")
		}
	}
	///	Transfers a call to destination of another running call. 
	/// This is used for "attended transfer" scenarios. The transfered call is supposed
	/// to be in paused state, so that it is able to accept the transfer immediately.
	/// The destination call is a call previously established to introduce the
	/// transfered person. This method will send a transfer request to the transfered
	/// person. The phone of the transfered is then expected to automatically call to
	/// the destination of the transfer. The receiver of the transfer will then
	/// automatically close the call with us (the 'dest' call). It is possible to
	/// follow the progress of the transfer provided that transferee sends notification
	/// about it. In this case, the transfer_state_changed callback of the
	/// LinphoneCoreVTable is invoked to notify of the state of the new call at the
	/// other party. The notified states are #LinphoneCallOutgoingInit ,
	/// #LinphoneCallOutgoingProgress, #LinphoneCallOutgoingRinging and
	/// #LinphoneCallConnected. 
	/// 
	/// - Parameter dest: A running call whose remote person will receive the transfer 
	/// 
	/// 
	/// - Returns: 0 on success, -1 on failure 
	public func transferToAnother(dest:Call) throws 
	{
		let exception_result = linphone_call_transfer_to_another(cPtr, dest.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "transferToAnother returned value \(exception_result)")
		}
	}
	///	Updates a running call according to supplied call parameters or parameters
	///	changed in the LinphoneCore. 
	/// It triggers a SIP reINVITE in order to perform a new offer/answer of media
	/// capabilities. Changing the size of the transmitted video after calling
	/// linphone_core_set_preferred_video_size can be used by passing nil as params
	/// argument. In case no changes are requested through the `CallParams` argument,
	/// then this argument can be omitted and set to nil. WARNING: Updating a call in
	/// the #LinphoneCallPaused state will still result in a paused call even if the
	/// media directions set in the params are sendrecv. To resume a paused call, you
	/// need to call {@link Call#resume}.
	/// 
	/// - Parameter params: The new call parameters to use (may be nil)    
	/// 
	/// 
	/// - Returns: 0 if successful, -1 otherwise. 
	public func update(params:CallParams?) throws 
	{
		let exception_result = linphone_call_update(cPtr, params?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "update returned value \(exception_result)")
		}
	}
	///	Perform a zoom of the video displayed during a call. 
	/// The zoom ensures that all the screen is fullfilled with the video. 
	/// 
	/// - Parameter zoomFactor: a floating point number describing the zoom factor. A
	/// value 1.0 corresponds to no zoom applied. 
	/// - Parameter cx: a floating point number pointing the horizontal center of the
	/// zoom to be applied. This value should be between 0.0 and 1.0. 
	/// - Parameter cy: a floating point number pointing the vertical center of the
	/// zoom to be applied. This value should be between 0.0 and 1.0. 
	/// 
	public func zoom(zoomFactor:Float, cx:Float, cy:Float) 
	{
		linphone_call_zoom(cPtr, zoomFactor, cx, cy)
	}
	///	Perform a zoom of the video displayed during a call. 
	/// - Parameter zoomFactor: a floating point number describing the zoom factor. A
	/// value 1.0 corresponds to no zoom applied. 
	/// - Parameter cx: a floating point number pointing the horizontal center of the
	/// zoom to be applied. This value should be between 0.0 and 1.0. 
	/// - Parameter cy: a floating point number pointing the vertical center of the
	/// zoom to be applied. This value should be between 0.0 and 1.0. 
	/// 
	/// 
	/// - deprecated: use linphone_call_zoom instead cx and cy are updated in return in
	/// case their coordinates were too excentrated for the requested zoom factor. The
	/// zoom ensures that all the screen is fullfilled with the video. 
	public func zoomVideo(zoomFactor:Float, cx:UnsafeMutablePointer<Float>, cy:UnsafeMutablePointer<Float>) 
	{
		linphone_call_zoom_video(cPtr, zoomFactor, cx, cy)
	}
}

/// Structure representing a call log. 
public class CallLog : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> CallLog {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<CallLog>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = CallLog(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Get the call ID used by the call. 
	/// - Returns: The call ID used by the call as a string. 
	public var callId: String
	{
			return charArrayToString(charPointer: linphone_call_log_get_call_id(cPtr))
	}

	/// Get the direction of the call. 
	/// - Returns: The direction of the call. 
	public var dir: Call.Dir
	{
			return Call.Dir(rawValue: Int(linphone_call_log_get_dir(cPtr).rawValue))!
	}

	/// Get the duration of the call since connected. 
	/// - Returns: The duration of the call in seconds. 
	public var duration: Int
	{
			return Int(linphone_call_log_get_duration(cPtr))
	}

	/// When the call was failed, return an object describing the failure. 
	/// - Returns: information about the error encountered by the call associated with
	/// this call log. 
	public var errorInfo: ErrorInfo?
	{
			let cPointer = linphone_call_log_get_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ErrorInfo.getSwiftObject(cObject:cPointer!)
	}

	/// Get the origin address (ie from) of the call. 
	/// - Returns: The origin address (ie from) of the call. 
	public var fromAddress: Address?
	{
			let cPointer = linphone_call_log_get_from_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Get the local address (that is from or to depending on call direction) 
	/// - Returns: The local address of the call 
	public var localAddress: Address?
	{
			let cPointer = linphone_call_log_get_local_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Get the overall quality indication of the call. 
	/// - Returns: The overall quality indication of the call. 
	public var quality: Float
	{
			return linphone_call_log_get_quality(cPtr)
	}

	/// Get the persistent reference key associated to the call log. 
	/// The reference key can be for example an id to an external database. It is
	/// stored in the config file, thus can survive to process exits/restarts.
	/// 
	/// - Returns: The reference key string that has been associated to the call log,
	/// or nil if none has been associated. 
	public var refKey: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_call_log_get_ref_key(cPtr))
		}
		set
		{
			linphone_call_log_set_ref_key(cPtr, newValue)
		}
	}

	/// Get the remote address (that is from or to depending on call direction). 
	/// - Returns: The remote address of the call. 
	public var remoteAddress: Address?
	{
			let cPointer = linphone_call_log_get_remote_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Get the start date of the call. 
	/// - Returns: The date of the beginning of the call. 
	public var startDate: time_t
	{
			return linphone_call_log_get_start_date(cPtr)
	}

	/// Get the status of the call. 
	/// - Returns: The status of the call. 
	public var status: Call.Status
	{
			return Call.Status(rawValue: Int(linphone_call_log_get_status(cPtr).rawValue))!
	}

	/// Get the destination address (ie to) of the call. 
	/// - Returns: The destination address (ie to) of the call. 
	public var toAddress: Address?
	{
			let cPointer = linphone_call_log_get_to_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Get the user data associated with the call log. 
	/// - Returns: The user data associated with the call log. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_call_log_get_user_data(cPtr)
		}
		set
		{
			linphone_call_log_set_user_data(cPtr, newValue)
		}
	}

	/// Tell whether video was enabled at the end of the call or not. 
	/// - Returns: A boolean value telling whether video was enabled at the end of the
	/// call. 
	public var videoEnabled: Bool
	{
			return linphone_call_log_video_enabled(cPtr) != 0
	}
	///	Get a human readable string describing the call. 
	/// - Note: : the returned string must be freed by the application (use ms_free()). 
	/// 
	/// - Returns: A human readable string describing the call. 
	public func toStr() -> String
	{
		return charArrayToString(charPointer: linphone_call_log_to_str(cPtr))
	}
	///	Tells whether that call was a call to a conference server. 
	/// - Returns:  if the call was a call to a conference server 
	public func wasConference() -> Bool
	{
		return linphone_call_log_was_conference(cPtr) != 0
	}
}

/// The `CallParams` is an object containing various call related parameters. 
/// It can be used to retrieve parameters from a currently running call or modify
/// the call's characteristics dynamically. 
public class CallParams : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> CallParams {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<CallParams>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = CallParams(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Refine bandwidth settings for this call by setting a bandwidth limit for audio
	/// streams. 
	/// As a consequence, codecs whose bitrates are not compatible with this limit
	/// won't be used. 
	/// 
	/// - Parameter bw: The audio bandwidth limit to set in kbit/s. 
	/// 
	public var audioBandwidthLimit: Int = 0
	{
		willSet
		{
			linphone_call_params_set_audio_bandwidth_limit(cPtr, CInt(newValue))
		}
	}

	/// Get the audio stream direction. 
	/// - Returns: The audio stream direction associated with the call params. 
	public var audioDirection: MediaDirection
	{
		get
		{
			return MediaDirection(rawValue: Int(linphone_call_params_get_audio_direction(cPtr).rawValue))!
		}
		set
		{
			linphone_call_params_set_audio_direction(cPtr, LinphoneMediaDirection(rawValue: CInt(newValue.rawValue)))
		}
	}

	/// Tell whether audio is enabled or not. 
	/// - Returns: A boolean value telling whether audio is enabled or not. 
	public var audioEnabled: Bool
	{
		get
		{
			return linphone_call_params_audio_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_audio(cPtr, newValue==true ? 1:0)
		}
	}

	/// Use to get multicast state of audio stream. 
	/// - Returns: true if subsequent calls will propose multicast ip set by
	/// linphone_core_set_audio_multicast_addr 
	public var audioMulticastEnabled: Bool
	{
		get
		{
			return linphone_call_params_audio_multicast_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_audio_multicast(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets a list of `Content` set if exists. 
	/// - Returns: A list of `Content` objects. LinphoneContent  A list of `Content`
	/// set if exists, nil otherwise. 
	public var customContents: [Content]
	{
			var swiftList = [Content]()
			var cList = linphone_call_params_get_custom_contents(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Content.getSwiftObject(cObject: data))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Indicate whether sending of early media was enabled. 
	/// - Returns: A boolean value telling whether sending of early media was enabled. 
	public var earlyMediaSendingEnabled: Bool
	{
		get
		{
			return linphone_call_params_early_media_sending_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_early_media_sending(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether the call is part of the locally managed conference. 
	/// - Warning: If a conference server is used to manage conferences, that function
	/// does not return true even if the conference is running. If you want to test
	/// whether the conference is running, you should test whether {@link
	/// Core#getConference} return a non-null pointer. 
	/// 
	/// - Returns: A boolean value telling whether the call is part of the locally
	/// managed conference. 
	public var localConferenceMode: Bool
	{
			return linphone_call_params_get_local_conference_mode(cPtr) != 0
	}

	/// Tell whether the call has been configured in low bandwidth mode or not. 
	/// This mode can be automatically discovered thanks to a stun server when
	/// activate_edge_workarounds=1 in section [net] of configuration file. An
	/// application that would have reliable way to know network capacity may not use
	/// activate_edge_workarounds=1 but instead manually configure low bandwidth mode
	/// with {@link CallParams#enableLowBandwidth}. When enabled, this param may
	/// transform a call request with video in audio only mode. 
	/// 
	/// - Returns: A boolean value telling whether the low bandwidth mode has been
	/// configured/detected. 
	public var lowBandwidthEnabled: Bool
	{
		get
		{
			return linphone_call_params_low_bandwidth_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_low_bandwidth(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the kind of media encryption selected for the call. 
	/// - Returns: The kind of media encryption selected for the call. 
	public var mediaEncryption: MediaEncryption
	{
		get
		{
			return MediaEncryption(rawValue: Int(linphone_call_params_get_media_encryption(cPtr).rawValue))!
		}
		set
		{
			linphone_call_params_set_media_encryption(cPtr, LinphoneMediaEncryption(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get requested level of privacy for the call. 
	/// - Returns: The privacy mode used for the call. 
	public var privacy: UInt
	{
		get
		{
			return UInt(linphone_call_params_get_privacy(cPtr))
		}
		set
		{
			linphone_call_params_set_privacy(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Use to get real time text following rfc4103. 
	/// - Returns: returns true if call rtt is activated. 
	public var realtimeTextEnabled: Bool
	{
			return linphone_call_params_realtime_text_enabled(cPtr) != 0
	}

	public func setRealtimetextenabled(newValue: Bool) throws
	{
		let exception_result = linphone_call_params_enable_realtime_text(cPtr, newValue==true ? 1:0)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Use to get keep alive interval of real time text following rfc4103. 
	/// - Returns: returns keep alive interval of real time text. 
	public var realtimeTextKeepaliveInterval: UInt
	{
		get
		{
			return UInt(linphone_call_params_get_realtime_text_keepalive_interval(cPtr))
		}
		set
		{
			linphone_call_params_set_realtime_text_keepalive_interval(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Get the framerate of the video that is received. 
	/// - Returns: The actual received framerate in frames per seconds, 0 if not
	/// available. 
	public var receivedFramerate: Float
	{
			return linphone_call_params_get_received_framerate(cPtr)
	}

	/// Get the definition of the received video. 
	/// - Returns: The received `VideoDefinition` 
	public var receivedVideoDefinition: VideoDefinition?
	{
			let cPointer = linphone_call_params_get_received_video_definition(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return VideoDefinition.getSwiftObject(cObject:cPointer!)
	}

	/// Get the path for the audio recording of the call. 
	/// - Returns: The path to the audio recording of the call. 
	public var recordFile: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_call_params_get_record_file(cPtr))
		}
		set
		{
			linphone_call_params_set_record_file(cPtr, newValue)
		}
	}

	/// Indicates whether RTP bundle mode (also known as Media Multiplexing) is
	/// enabled. 
	/// See https://tools.ietf.org/html/draft-ietf-mmusic-sdp-bundle-negotiation-54 for
	/// more information. 
	/// 
	/// - Returns: a boolean indicating the enablement of rtp bundle mode. 
	public var rtpBundleEnabled: Bool
	{
		get
		{
			return linphone_call_params_rtp_bundle_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_rtp_bundle(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the RTP profile being used. 
	/// - Returns: The RTP profile. 
	public var rtpProfile: String
	{
			return charArrayToString(charPointer: linphone_call_params_get_rtp_profile(cPtr))
	}

	/// Get the framerate of the video that is sent. 
	/// - Returns: The actual sent framerate in frames per seconds, 0 if not available. 
	public var sentFramerate: Float
	{
			return linphone_call_params_get_sent_framerate(cPtr)
	}

	/// Get the definition of the sent video. 
	/// - Returns: The sent `VideoDefinition` 
	public var sentVideoDefinition: VideoDefinition?
	{
			let cPointer = linphone_call_params_get_sent_video_definition(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return VideoDefinition.getSwiftObject(cObject:cPointer!)
	}

	/// Get the session name of the media session (ie in SDP). 
	/// Subject from the SIP message can be retrieved using {@link
	/// CallParams#getCustomHeader} and is different. 
	/// 
	/// - Returns: The session name of the media session. 
	public var sessionName: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_call_params_get_session_name(cPtr))
		}
		set
		{
			linphone_call_params_set_session_name(cPtr, newValue)
		}
	}

	/// Get the audio payload type that has been selected by a call. 
	/// - Returns: The selected payload type. nil is returned if no audio payload type
	/// has been seleced by the call. 
	public var usedAudioPayloadType: PayloadType?
	{
			let cPointer = linphone_call_params_get_used_audio_payload_type(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return PayloadType.getSwiftObject(cObject:cPointer!)
	}

	/// Get the text payload type that has been selected by a call. 
	/// - Returns: The selected payload type. nil is returned if no text payload type
	/// has been seleced by the call. 
	public var usedTextPayloadType: PayloadType?
	{
			let cPointer = linphone_call_params_get_used_text_payload_type(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return PayloadType.getSwiftObject(cObject:cPointer!)
	}

	/// Get the video payload type that has been selected by a call. 
	/// - Returns: The selected payload type. nil is returned if no video payload type
	/// has been seleced by the call. 
	public var usedVideoPayloadType: PayloadType?
	{
			let cPointer = linphone_call_params_get_used_video_payload_type(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return PayloadType.getSwiftObject(cObject:cPointer!)
	}

	/// Get the user data associated with the call params. 
	/// - Returns: The user data associated with the call params. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_call_params_get_user_data(cPtr)
		}
		set
		{
			linphone_call_params_set_user_data(cPtr, newValue)
		}
	}

	/// Get the video stream direction. 
	/// - Returns: The video stream direction associated with the call params. 
	public var videoDirection: MediaDirection
	{
		get
		{
			return MediaDirection(rawValue: Int(linphone_call_params_get_video_direction(cPtr).rawValue))!
		}
		set
		{
			linphone_call_params_set_video_direction(cPtr, LinphoneMediaDirection(rawValue: CInt(newValue.rawValue)))
		}
	}

	/// Tell whether video is enabled or not. 
	/// - Returns: A boolean value telling whether video is enabled or not. 
	public var videoEnabled: Bool
	{
		get
		{
			return linphone_call_params_video_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_video(cPtr, newValue==true ? 1:0)
		}
	}

	/// Use to get multicast state of video stream. 
	/// - Returns: true if subsequent calls will propose multicast ip set by
	/// linphone_core_set_video_multicast_addr 
	public var videoMulticastEnabled: Bool
	{
		get
		{
			return linphone_call_params_video_multicast_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_video_multicast(cPtr, newValue==true ? 1:0)
		}
	}
	///	Adds a `Content` to be added to the INVITE SDP. 
	/// - Parameter content: The `Content` to be added. 
	/// 
	public func addCustomContent(content:Content) 
	{
		linphone_call_params_add_custom_content(cPtr, content.cPtr)
	}
	///	Add a custom SIP header in the INVITE for a call. 
	/// - Parameter headerName: The name of the header to add. 
	/// - Parameter headerValue: The content of the header to add. 
	/// 
	public func addCustomHeader(headerName:String, headerValue:String) 
	{
		linphone_call_params_add_custom_header(cPtr, headerName, headerValue)
	}
	///	Add a custom attribute related to all the streams in the SDP exchanged within
	///	SIP messages during a call. 
	/// - Parameter attributeName: The name of the attribute to add. 
	/// - Parameter attributeValue: The content value of the attribute to add. 
	/// 
	public func addCustomSdpAttribute(attributeName:String, attributeValue:String) 
	{
		linphone_call_params_add_custom_sdp_attribute(cPtr, attributeName, attributeValue)
	}
	///	Add a custom attribute related to a specific stream in the SDP exchanged within
	///	SIP messages during a call. 
	/// - Parameter type: The type of the stream to add a custom SDP attribute to. 
	/// - Parameter attributeName: The name of the attribute to add. 
	/// - Parameter attributeValue: The content value of the attribute to add. 
	/// 
	public func addCustomSdpMediaAttribute(type:StreamType, attributeName:String, attributeValue:String) 
	{
		linphone_call_params_add_custom_sdp_media_attribute(cPtr, LinphoneStreamType(rawValue: CUnsignedInt(type.rawValue)), attributeName, attributeValue)
	}
	///	Clear the custom SDP attributes related to all the streams in the SDP exchanged
	///	within SIP messages during a call. 
	public func clearCustomSdpAttributes() 
	{
		linphone_call_params_clear_custom_sdp_attributes(cPtr)
	}
	///	Clear the custom SDP attributes related to a specific stream in the SDP
	///	exchanged within SIP messages during a call. 
	/// - Parameter type: The type of the stream to clear the custom SDP attributes
	/// from. 
	/// 
	public func clearCustomSdpMediaAttributes(type:StreamType) 
	{
		linphone_call_params_clear_custom_sdp_media_attributes(cPtr, LinphoneStreamType(rawValue: CUnsignedInt(type.rawValue)))
	}
	///	Copy an existing `CallParams` object to a new `CallParams` object. 
	/// - Returns: A copy of the `CallParams` object. 
	public func copy() -> CallParams?
	{
		let cPointer = linphone_call_params_copy(cPtr)
		if (cPointer == nil) {
			return nil
		}
		return CallParams.getSwiftObject(cObject: cPointer!)
	}
	///	Get a custom SIP header. 
	/// - Parameter headerName: The name of the header to get. 
	/// 
	/// 
	/// - Returns: The content of the header or nil if not found. 
	public func getCustomHeader(headerName:String) -> String
	{
		return charArrayToString(charPointer: linphone_call_params_get_custom_header(cPtr, headerName))
	}
	///	Get a custom SDP attribute that is related to all the streams. 
	/// - Parameter attributeName: The name of the attribute to get. 
	/// 
	/// 
	/// - Returns: The content value of the attribute or nil if not found. 
	public func getCustomSdpAttribute(attributeName:String) -> String
	{
		return charArrayToString(charPointer: linphone_call_params_get_custom_sdp_attribute(cPtr, attributeName))
	}
	///	Get a custom SDP attribute that is related to a specific stream. 
	/// - Parameter type: The type of the stream to add a custom SDP attribute to. 
	/// - Parameter attributeName: The name of the attribute to get. 
	/// 
	/// 
	/// - Returns: The content value of the attribute or nil if not found. 
	public func getCustomSdpMediaAttribute(type:StreamType, attributeName:String) -> String
	{
		return charArrayToString(charPointer: linphone_call_params_get_custom_sdp_media_attribute(cPtr, LinphoneStreamType(rawValue: CUnsignedInt(type.rawValue)), attributeName))
	}
}

/// The `CallStats` objects carries various statistic informations regarding
/// quality of audio or video streams. 
/// To receive these informations periodically and as soon as they are computed,
/// the application is invited to place a LinphoneCoreCallStatsUpdatedCb callback
/// in the LinphoneCoreVTable structure it passes for instanciating the `Core`
/// object (see linphone_core_new ).
/// 
/// At any time, the application can access last computed statistics using
/// linphone_call_get_audio_stats() or linphone_call_get_video_stats(). 
public class CallStats : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> CallStats {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<CallStats>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = CallStats(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Get the bandwidth measurement of the received stream, expressed in kbit/s,
	/// including IP/UDP/RTP headers. 
	/// - Returns: The bandwidth measurement of the received stream in kbit/s. 
	public var downloadBandwidth: Float
	{
			return linphone_call_stats_get_download_bandwidth(cPtr)
	}

	/// Get the estimated bandwidth measurement of the received stream, expressed in
	/// kbit/s, including IP/UDP/RTP headers. 
	/// - Returns: The estimated bandwidth measurement of the received stream in
	/// kbit/s. 
	public var estimatedDownloadBandwidth: Float
	{
			return linphone_call_stats_get_estimated_download_bandwidth(cPtr)
	}

	/// Get the state of ICE processing. 
	/// - Returns: The state of ICE processing. 
	public var iceState: IceState
	{
			return IceState(rawValue: Int(linphone_call_stats_get_ice_state(cPtr).rawValue))!
	}

	/// Get the IP address family of the remote peer. 
	/// - Returns: The IP address family of the remote peer. 
	public var ipFamilyOfRemote: AddressFamily
	{
			return AddressFamily(rawValue: Int(linphone_call_stats_get_ip_family_of_remote(cPtr).rawValue))!
	}

	/// Get the jitter buffer size in ms. 
	/// - Returns: The jitter buffer size in ms. 
	public var jitterBufferSizeMs: Float
	{
			return linphone_call_stats_get_jitter_buffer_size_ms(cPtr)
	}

	/// Gets the cumulative number of late packets. 
	/// - Returns: The cumulative number of late packets 
	public var latePacketsCumulativeNumber: UInt64
	{
			return linphone_call_stats_get_late_packets_cumulative_number(cPtr)
	}

	/// Gets the local late rate since last report. 
	/// - Returns: The local late rate 
	public var localLateRate: Float
	{
			return linphone_call_stats_get_local_late_rate(cPtr)
	}

	/// Get the local loss rate since last report. 
	/// - Returns: The local loss rate 
	public var localLossRate: Float
	{
			return linphone_call_stats_get_local_loss_rate(cPtr)
	}

	/// Gets the remote reported interarrival jitter. 
	/// - Returns: The interarrival jitter at last received receiver report 
	public var receiverInterarrivalJitter: Float
	{
			return linphone_call_stats_get_receiver_interarrival_jitter(cPtr)
	}

	/// Gets the remote reported loss rate since last report. 
	/// - Returns: The receiver loss rate 
	public var receiverLossRate: Float
	{
			return linphone_call_stats_get_receiver_loss_rate(cPtr)
	}

	/// Get the round trip delay in s. 
	/// - Returns: The round trip delay in s. 
	public var roundTripDelay: Float
	{
			return linphone_call_stats_get_round_trip_delay(cPtr)
	}

	/// Get the bandwidth measurement of the received RTCP, expressed in kbit/s,
	/// including IP/UDP/RTP headers. 
	/// - Returns: The bandwidth measurement of the received RTCP in kbit/s. 
	public var rtcpDownloadBandwidth: Float
	{
			return linphone_call_stats_get_rtcp_download_bandwidth(cPtr)
	}

	/// Get the bandwidth measurement of the sent RTCP, expressed in kbit/s, including
	/// IP/UDP/RTP headers. 
	/// - Returns: The bandwidth measurement of the sent RTCP in kbit/s. 
	public var rtcpUploadBandwidth: Float
	{
			return linphone_call_stats_get_rtcp_upload_bandwidth(cPtr)
	}

	/// Gets the local interarrival jitter. 
	/// - Returns: The interarrival jitter at last emitted sender report 
	public var senderInterarrivalJitter: Float
	{
			return linphone_call_stats_get_sender_interarrival_jitter(cPtr)
	}

	/// Get the local loss rate since last report. 
	/// - Returns: The sender loss rate 
	public var senderLossRate: Float
	{
			return linphone_call_stats_get_sender_loss_rate(cPtr)
	}

	/// Get the type of the stream the stats refer to. 
	/// - Returns: The type of the stream the stats refer to 
	public var type: StreamType
	{
			return StreamType(rawValue: Int(linphone_call_stats_get_type(cPtr).rawValue))!
	}

	/// Get the bandwidth measurement of the sent stream, expressed in kbit/s,
	/// including IP/UDP/RTP headers. 
	/// - Returns: The bandwidth measurement of the sent stream in kbit/s. 
	public var uploadBandwidth: Float
	{
			return linphone_call_stats_get_upload_bandwidth(cPtr)
	}

	/// Get the state of uPnP processing. 
	/// - Returns: The state of uPnP processing. 
	public var upnpState: UpnpState
	{
			return UpnpState(rawValue: Int(linphone_call_stats_get_upnp_state(cPtr).rawValue))!
	}

	/// Gets the user data in the `CallStats` object. 
	/// - Returns: the user data 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_call_stats_get_user_data(cPtr)
		}
		set
		{
			linphone_call_stats_set_user_data(cPtr, newValue)
		}
	}
}

/// An chat message is the object that is sent and received through
/// LinphoneChatRooms. 
public class ChatMessage : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> ChatMessage {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ChatMessage>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ChatMessage(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	///LinphoneChatMessageDirection is used to indicate if a message is outgoing or
	///incoming. 
	public enum Direction:Int
	{
		/// Incoming message. 
		case Incoming = 0
		/// Outgoing message. 
		case Outgoing = 1
	}

	///LinphoneChatMessageState is used to notify if messages have been successfully
	///delivered or not. 
	public enum State:Int
	{
		/// Initial state. 
		case Idle = 0
		/// Delivery in progress. 
		case InProgress = 1
		/// Message successfully delivered and acknowledged by the server. 
		case Delivered = 2
		/// Message was not delivered. 
		case NotDelivered = 3
		/// Message was received and acknowledged but cannot get file from server. 
		case FileTransferError = 4
		/// File transfer has been completed successfully. 
		case FileTransferDone = 5
		/// Message successfully delivered an acknowledged by the remote user. 
		case DeliveredToUser = 6
		/// Message successfully displayed to the remote user. 
		case Displayed = 7
		case FileTransferInProgress = 8
	}
	public func getDelegate() -> ChatMessageDelegate?
	{
		let cObject = linphone_chat_message_get_callbacks(cPtr)
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ChatMessageDelegate>.fromOpaque(result!).takeUnretainedValue()
			}
		return nil
	}
	public func addDelegate(delegate: ChatMessageDelegate)
	{
		linphone_chat_message_add_callbacks(cPtr, delegate.cPtr)
	}
	public func removeDelegate(delegate: ChatMessageDelegate)
	{
		linphone_chat_message_remove_callbacks(cPtr, delegate.cPtr)
	}

	/// Linphone message has an app-specific field that can store a text. 
	/// The application might want to use it for keeping data over restarts, like
	/// thumbnail image path. 
	/// 
	/// - Returns: the application-specific data or nil if none has been stored. 
	public var appdata: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_chat_message_get_appdata(cPtr))
		}
		set
		{
			linphone_chat_message_set_appdata(cPtr, newValue)
		}
	}

	/// Gets the callId accociated with the message. 
	/// - Returns: the call Id 
	public var callId: String
	{
			return charArrayToString(charPointer: linphone_chat_message_get_call_id(cPtr))
	}

	/// Returns the chatroom this message belongs to. 
	public var chatRoom: ChatRoom?
	{
			let cPointer = linphone_chat_message_get_chat_room(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ChatRoom.getSwiftObject(cObject:cPointer!)
	}

	/// Get the content type of a chat message. 
	/// - Returns: The content type of the chat message 
	public var contentType: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_chat_message_get_content_type(cPtr))
		}
		set
		{
			linphone_chat_message_set_content_type(cPtr, newValue)
		}
	}

	/// Returns the list of contents in the message. 
	/// - Returns: A list of `Content` objects. LinphoneContent  the list of `Content`. 
	public var contents: [Content]
	{
			var swiftList = [Content]()
			var cList = linphone_chat_message_get_contents(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Content.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Returns back pointer to `Core` object. 
	public var core: Core?
	{
			let cPointer = linphone_chat_message_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Core.getSwiftObject(cObject:cPointer!)
	}

	/// Gets the current LinphoneChatMessageCbs. 
	/// This is meant only to be called from a callback to be able to get the user_data
	/// associated with the LinphoneChatMessageCbs that is calling the callback. 
	/// 
	/// - Returns: The LinphoneChatMessageCbs that has called the last callback 
	public var currentCallbacks: ChatMessageDelegate?
	{
			let cObject = linphone_chat_message_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<ChatMessageDelegate>.fromOpaque(result!).takeUnretainedValue()
				}
			return nil
	}

	/// Returns the real time at which an ephemeral message expires and will be
	/// deleted. 
	/// - Returns: the time at which an ephemeral message expires. 0 means the message
	/// has not been read. 
	public var ephemeralExpireTime: time_t
	{
			return linphone_chat_message_get_ephemeral_expire_time(cPtr)
	}

	/// Returns lifetime of an ephemeral message. 
	/// The lifetime is the duration after which the ephemeral message will disappear
	/// once viewed. 
	/// 
	/// - Returns: the lifetime of an ephemeral message, by default 86400s. 
	public var ephemeralLifetime: Int
	{
			return Int(linphone_chat_message_get_ephemeral_lifetime(cPtr))
	}

	/// Get full details about delivery error of a chat message. 
	/// - Returns: a `ErrorInfo` describing the details. 
	public var errorInfo: ErrorInfo?
	{
			let cPointer = linphone_chat_message_get_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ErrorInfo.getSwiftObject(cObject:cPointer!)
	}

	/// Linphone message can carry external body as defined by rfc2017. 
	/// - Returns: external body url or nil if not present. 
	public var externalBodyUrl: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_chat_message_get_external_body_url(cPtr))
		}
		set
		{
			linphone_chat_message_set_external_body_url(cPtr, newValue)
		}
	}

	/// Get the path to the file to read from or write to during the file transfer. 
	/// - Returns: The path to the file to use for the file transfer. 
	/// 
	/// - deprecated: use {@link Content#getFilePath} instead. 
	public var fileTransferFilepath: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_chat_message_get_file_transfer_filepath(cPtr))
		}
		set
		{
			linphone_chat_message_set_file_transfer_filepath(cPtr, newValue)
		}
	}

	/// Get the file_transfer_information (used by call backs to recover informations
	/// during a rcs file transfer) 
	/// - Returns: a pointer to the `Content` structure or nil if not present. 
	public var fileTransferInformation: Content?
	{
			let cPointer = linphone_chat_message_get_file_transfer_information(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Content.getSwiftObject(cObject:cPointer!)
	}

	/// Gets the forward info if available as a string. 
	/// - Returns: the original sender of the message if it has been forwarded, null
	/// otherwise 
	public var forwardInfo: String
	{
			return charArrayToString(charPointer: linphone_chat_message_get_forward_info(cPtr))
	}

	/// Get origin of the message. 
	/// - Returns: `Address` 
	public var fromAddress: Address?
	{
			let cPointer = linphone_chat_message_get_from_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Returns true if the chat message is an ephemeral message. 
	/// An ephemeral message will automatically disappear from the recipient's screen
	/// after the message has been viewed. 
	/// 
	/// - Returns: true if it is an ephemeral message, false otherwise 
	public var isEphemeral: Bool
	{
			return linphone_chat_message_is_ephemeral(cPtr) != 0
	}

	/// Return whether or not a chat message is a file transfer. 
	/// - Returns: Whether or not the message is a file transfer 
	public var isFileTransfer: Bool
	{
			return linphone_chat_message_is_file_transfer(cPtr) != 0
	}

	/// Gets whether or not a file is currently being downloaded or uploaded. 
	/// - Returns: true if download or upload is in progress, false otherwise 
	public var isFileTransferInProgress: Bool
	{
			return linphone_chat_message_is_file_transfer_in_progress(cPtr) != 0
	}

	/// Returns true if the chat message is a forward message. 
	/// - Returns: true if it is a forward message, false otherwise 
	public var isForward: Bool
	{
			return linphone_chat_message_is_forward(cPtr) != 0
	}

	/// Returns true if the message has been sent, returns true if the message has been
	/// received. 
	public var isOutgoing: Bool
	{
			return linphone_chat_message_is_outgoing(cPtr) != 0
	}

	/// Returns true if the message has been read, otherwise returns true. 
	public var isRead: Bool
	{
			return linphone_chat_message_is_read(cPtr) != 0
	}

	/// Get if the message was encrypted when transfered. 
	/// - Returns: whether the message was encrypted when transfered or not 
	public var isSecured: Bool
	{
			return linphone_chat_message_is_secured(cPtr) != 0
	}

	/// Return whether or not a chat message is a text. 
	/// - Returns: Whether or not the message is a text 
	public var isText: Bool
	{
			return linphone_chat_message_is_text(cPtr) != 0
	}

	/// Returns the origin address of a message if it was a outgoing message, or the
	/// destination address if it was an incoming message. 
	/// - Returns: `Address` 
	public var localAddress: Address?
	{
			let cPointer = linphone_chat_message_get_local_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Get the message identifier. 
	/// It is used to identify a message so that it can be notified as delivered and/or
	/// displayed. 
	/// 
	/// - Returns: The message identifier. 
	public var messageId: String
	{
			return charArrayToString(charPointer: linphone_chat_message_get_message_id(cPtr))
	}

	/// Get the state of the message. 
	/// - Returns: LinphoneChatMessageState 
	public var state: ChatMessage.State
	{
			return ChatMessage.State(rawValue: Int(linphone_chat_message_get_state(cPtr).rawValue))!
	}

	/// Get text part of this message. 
	/// - Returns: text or nil if no text. 
	/// 
	/// - deprecated: use getTextContent() instead 
	public var text: String
	{
			return charArrayToString(charPointer: linphone_chat_message_get_text(cPtr))
	}

	/// Gets the text content if available as a string. 
	/// - Returns: the `Content` buffer if available, null otherwise 
	public var textContent: String
	{
			return charArrayToString(charPointer: linphone_chat_message_get_text_content(cPtr))
	}

	/// Get the time the message was sent. 
	public var time: time_t
	{
			return linphone_chat_message_get_time(cPtr)
	}

	/// Get destination of the message. 
	/// - Returns: `Address` 
	public var toAddress: Address?
	{
			let cPointer = linphone_chat_message_get_to_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Get if a chat message is to be stored. 
	/// - Returns: Whether or not the message is to be stored 
	public var toBeStored: Bool
	{
		get
		{
			return linphone_chat_message_get_to_be_stored(cPtr) != 0
		}
		set
		{
			linphone_chat_message_set_to_be_stored(cPtr, newValue==true ? 1:0)
		}
	}

	/// Retrieve the user pointer associated with the chat message. 
	/// - Returns: The user pointer associated with the chat message. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_chat_message_get_user_data(cPtr)
		}
		set
		{
			linphone_chat_message_set_user_data(cPtr, newValue)
		}
	}
	///	Add custom headers to the message. 
	/// - Parameter headerName: name of the header 
	/// - Parameter headerValue: header value 
	/// 
	public func addCustomHeader(headerName:String, headerValue:String) 
	{
		linphone_chat_message_add_custom_header(cPtr, headerName, headerValue)
	}
	///	Adds a file content to the ChatMessage. 
	/// - Parameter cContent: `Content` object to add. 
	/// 
	public func addFileContent(cContent:Content) 
	{
		linphone_chat_message_add_file_content(cPtr, cContent.cPtr)
	}
	///	Adds a text content to the ChatMessage. 
	/// - Parameter text: The text to add to the message. 
	/// 
	public func addTextContent(text:String) 
	{
		linphone_chat_message_add_text_content(cPtr, text)
	}
	///	Cancel an ongoing file transfer attached to this message. 
	/// (upload or download) 
	public func cancelFileTransfer() 
	{
		linphone_chat_message_cancel_file_transfer(cPtr)
	}
	///	Start the download of the `Content` referenced in the `ChatMessage` from remote
	///	server. 
	/// - Parameter cContent: `Content` object to download. 
	/// 
	public func downloadContent(cContent:Content) -> Bool
	{
		return linphone_chat_message_download_content(cPtr, cContent.cPtr) != 0
	}
	///	Start the download of the file referenced in a `ChatMessage` from remote
	///	server. 
	/// - deprecated: Use {@link ChatMessage#downloadContent} instead 
	public func downloadFile() -> Bool
	{
		return linphone_chat_message_download_file(cPtr) != 0
	}
	///	Retrieve a custom header value given its name. 
	/// - Parameter headerName: header name searched 
	/// 
	public func getCustomHeader(headerName:String) -> String
	{
		return charArrayToString(charPointer: linphone_chat_message_get_custom_header(cPtr, headerName))
	}
	///	Gets the list of participants for which the imdn state has reached the
	///	specified state and the time at which they did. 
	/// - Parameter state: The LinphoneChatMessageState the imdn have reached (only use
	/// LinphoneChatMessageStateDelivered, LinphoneChatMessageStateDeliveredToUser,
	/// LinphoneChatMessageStateDisplayed and LinphoneChatMessageStateNotDelivered) 
	/// 
	/// 
	/// - Returns: A list of `ParticipantImdnState` objects.
	/// LinphoneParticipantImdnState  The objects inside the list are freshly allocated
	/// with a reference counter equal to one, so they need to be freed on list
	/// destruction with bctbx_list_free_with_data() for instance.   
	public func getParticipantsByImdnState(state:ChatMessage.State) -> [ParticipantImdnState]
	{
		var swiftList = [ParticipantImdnState]()
		var cList = linphone_chat_message_get_participants_by_imdn_state(cPtr, LinphoneChatMessageState(rawValue: CUnsignedInt(state.rawValue)))
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(ParticipantImdnState.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Returns true if the chat message has a text content. 
	/// - Returns: true if it has one, false otherwise 
	public func hasTextContent() -> Bool
	{
		return linphone_chat_message_has_text_content(cPtr) != 0
	}
	///	Fulfill a chat message char by char. 
	/// Message linked to a Real Time Text Call send char in realtime following RFC
	/// 4103/T.140 To commit a message, use linphone_chat_room_send_message 
	/// 
	/// - Parameter character: T.140 char 
	/// 
	/// 
	/// - Returns: 0 if succeed. 
	public func putChar(character:UInt32) throws 
	{
		let exception_result = linphone_chat_message_put_char(cPtr, character)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "putChar returned value \(exception_result)")
		}
	}
	///	Removes a content from the ChatMessage. 
	/// - Parameter content: the `Content` object to remove. 
	/// 
	public func removeContent(content:Content) 
	{
		linphone_chat_message_remove_content(cPtr, content.cPtr)
	}
	///	Removes a custom header from the message. 
	/// - Parameter headerName: name of the header to remove 
	/// 
	public func removeCustomHeader(headerName:String) 
	{
		linphone_chat_message_remove_custom_header(cPtr, headerName)
	}
	///	Resend a chat message if it is in the 'not delivered' state for whatever
	///	reason. 
	/// - Note: Unlike linphone_chat_message_resend, that function only takes a
	/// reference on the `ChatMessage` instead of totaly takes ownership on it. Thus,
	/// the `ChatMessage` object must be released by the API user after calling that
	/// function.
	public func resend() 
	{
		linphone_chat_message_resend_2(cPtr)
	}
	///	Send a chat message. 
	public func send() 
	{
		linphone_chat_message_send(cPtr)
	}
}

/// A chat room is the place where text messages are exchanged. 
/// Can be created by {@link Core#createChatRoom}. 
public class ChatRoom : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> ChatRoom {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ChatRoom>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ChatRoom(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	///LinphoneChatRoomState is used to indicate the current state of a chat room. 
	public enum State:Int
	{
		/// Initial state. 
		case None = 0
		/// Chat room is now instantiated on local. 
		case Instantiated = 1
		/// One creation request was sent to the server. 
		case CreationPending = 2
		/// Chat room was created on the server. 
		case Created = 3
		/// Chat room creation failed. 
		case CreationFailed = 4
		/// Wait for chat room termination. 
		case TerminationPending = 5
		/// Chat room exists on server but not in local. 
		case Terminated = 6
		/// The chat room termination failed. 
		case TerminationFailed = 7
		/// Chat room was deleted on the server. 
		case Deleted = 8
	}
	public func addDelegate(delegate: ChatRoomDelegate)
	{
		linphone_chat_room_add_callbacks(cPtr, delegate.cPtr)
	}
	public func removeDelegate(delegate: ChatRoomDelegate)
	{
		linphone_chat_room_remove_callbacks(cPtr, delegate.cPtr)
	}

	/// get Curent Call associated to this chatroom if any To commit a message, use
	/// linphone_chat_room_send_message 
	/// - Returns: `Call` or nil. 
	public var call: Call?
	{
			let cPointer = linphone_chat_room_get_call(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Call.getSwiftObject(cObject:cPointer!)
	}

	/// Get the capabilities of a chat room. 
	/// - Returns: The capabilities of the chat room 
	public var capabilities: UInt
	{
			return UInt(linphone_chat_room_get_capabilities(cPtr))
	}

	/// When realtime text is enabled linphone_call_params_realtime_text_enabled,
	/// LinphoneCoreIsComposingReceivedCb is call everytime a char is received from
	/// peer. 
	/// At the end of remote typing a regular `ChatMessage` is received with committed
	/// data from LinphoneCoreMessageReceivedCb. 
	/// 
	/// - Returns: RFC 4103/T.140 char 
	public var char: UInt32
	{
			return linphone_chat_room_get_char(cPtr)
	}

	/// Gets the list of participants that are currently composing. 
	/// - Returns: A list of `Address` objects. LinphoneAddress  list of addresses that
	/// are in the is_composing state 
	public var composingAddresses: [Address]
	{
			var swiftList = [Address]()
			var cList = linphone_chat_room_get_composing_addresses(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Address.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Get the conference address of the chat room. 
	/// - Returns: The conference address of the chat room or nil if this type of chat
	/// room is not conference based 
	public var conferenceAddress: Address?
	{
		get
		{
			let cPointer = linphone_chat_room_get_conference_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_chat_room_set_conference_address(cPtr, newValue?.cPtr)
		}
	}

	/// Returns back pointer to `Core` object. 
	public var core: Core?
	{
			let cPointer = linphone_chat_room_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Core.getSwiftObject(cObject:cPointer!)
	}

	/// Gets the current LinphoneChatRoomCbs. 
	/// This is meant only to be called from a callback to be able to get the user_data
	/// associated with the LinphoneChatRoomCbs that is calling the callback. 
	/// 
	/// - Returns: The LinphoneChatRoomCbs that has called the last callback 
	public var currentCallbacks: ChatRoomDelegate?
	{
			let cObject = linphone_chat_room_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<ChatRoomDelegate>.fromOpaque(result!).takeUnretainedValue()
				}
			return nil
	}

	/// Returns current parameters associated with the chat room. 
	/// This is typically the parameters passed at chat room creation to {@link
	/// Core#createChatRoom} or some default parameters if no `ChatRoomParams` was
	/// explicitely passed during chat room creation. 
	/// 
	/// - Returns: the chat room current parameters. 
	public var currentParams: ChatRoomParams?
	{
			let cPointer = linphone_chat_room_get_current_params(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ChatRoomParams.getSwiftObject(cObject:cPointer!)
	}

	/// Returns whether or not the ephemeral message feature is enabled in the chat
	/// room. 
	/// - Returns: true if ephemeral is enabled, false otherwise. 
	public var ephemeralEnabled: Bool
	{
		get
		{
			return linphone_chat_room_ephemeral_enabled(cPtr) != 0
		}
		set
		{
			linphone_chat_room_enable_ephemeral(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get lifetime (in seconds) for all new ephemeral messages in the chat room. 
	/// After the message is read, it will be deleted after "time" seconds. 
	/// 
	/// - Returns: the ephemeral lifetime (in secoonds) 
	public var ephemeralLifetime: Int
	{
		get
		{
			return Int(linphone_chat_room_get_ephemeral_lifetime(cPtr))
		}
		set
		{
			linphone_chat_room_set_ephemeral_lifetime(cPtr, (newValue))
		}
	}

	/// Gets the number of events in a chat room. 
	/// - Returns: the number of events. 
	public var historyEventsSize: Int
	{
			return Int(linphone_chat_room_get_history_events_size(cPtr))
	}

	/// Gets the number of messages in a chat room. 
	/// - Returns: the number of messages. 
	public var historySize: Int
	{
			return Int(linphone_chat_room_get_history_size(cPtr))
	}

	/// Returns whether or not a `ChatRoom` has at least one `ChatMessage` or not. 
	/// - Returns: true if there are no `ChatMessage`, false otherwise. 
	public var isEmpty: Bool
	{
			return linphone_chat_room_is_empty(cPtr) != 0
	}

	/// Tells whether the remote is currently composing a message. 
	/// - Returns:  if the remote is currently composing a message, true otherwise. 
	public var isRemoteComposing: Bool
	{
			return linphone_chat_room_is_remote_composing(cPtr) != 0
	}

	/// Gets the last chat message sent or received in this chat room. 
	/// - Returns: the latest `ChatMessage` 
	public var lastMessageInHistory: ChatMessage?
	{
			let cPointer = linphone_chat_room_get_last_message_in_history(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ChatMessage.getSwiftObject(cObject:cPointer!)
	}

	/// Return the last updated time for the chat room. 
	/// - Returns: the last updated time 
	public var lastUpdateTime: time_t
	{
			return linphone_chat_room_get_last_update_time(cPtr)
	}

	/// get local address associated to  this `ChatRoom` 
	/// - Returns: `Address` local address 
	public var localAddress: Address?
	{
			let cPointer = linphone_chat_room_get_local_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Get the participant representing myself in the chat room. 
	/// - Returns: The participant representing myself in the conference. 
	public var me: Participant?
	{
			let cPointer = linphone_chat_room_get_me(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Participant.getSwiftObject(cObject:cPointer!)
	}

	/// Get the number of participants in the chat room (that is without ourselves). 
	/// - Returns: The number of participants in the chat room 
	public var nbParticipants: Int
	{
			return Int(linphone_chat_room_get_nb_participants(cPtr))
	}

	/// Get the list of participants of a chat room. 
	/// - Returns: A list of LinphoneParticipant objects. LinphoneParticipant  
	public var participants: [Participant]
	{
			var swiftList = [Participant]()
			var cList = linphone_chat_room_get_participants(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Participant.getSwiftObject(cObject: data))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// get peer address associated to  this `ChatRoom` 
	/// - Returns: `Address` peer address 
	public var peerAddress: Address?
	{
			let cPointer = linphone_chat_room_get_peer_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Get the security level of a chat room. 
	/// - Returns: The security level of the chat room 
	public var securityLevel: ChatRoomSecurityLevel
	{
			return ChatRoomSecurityLevel(rawValue: Int(linphone_chat_room_get_security_level(cPtr).rawValue))!
	}

	/// Get the state of the chat room. 
	/// - Returns: The state of the chat room 
	public var state: ChatRoom.State
	{
			return ChatRoom.State(rawValue: Int(linphone_chat_room_get_state(cPtr).rawValue))!
	}

	/// Get the subject of a chat room. 
	/// - Returns: The subject of the chat room 
	public var subject: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_chat_room_get_subject(cPtr))
		}
		set
		{
			linphone_chat_room_set_subject(cPtr, newValue)
		}
	}

	/// Gets the number of unread messages in the chatroom. 
	/// - Returns: the number of unread messages. 
	public var unreadMessagesCount: Int
	{
			return Int(linphone_chat_room_get_unread_messages_count(cPtr))
	}

	/// Retrieve the user pointer associated with the chat room. 
	/// - Returns: The user pointer associated with the chat room. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_chat_room_get_user_data(cPtr)
		}
		set
		{
			linphone_chat_room_set_user_data(cPtr, newValue)
		}
	}
	///	Add a participant to a chat room. 
	/// This may fail if this type of chat room does not handle participants. Use
	/// {@link ChatRoom#canHandleParticipants} to know if this chat room handles
	/// participants. 
	/// 
	/// - Parameter addr: The address of the participant to add to the chat room 
	/// 
	public func addParticipant(addr:Address) 
	{
		linphone_chat_room_add_participant(cPtr, addr.cPtr)
	}
	///	Add several participants to a chat room at once. 
	/// This may fail if this type of chat room does not handle participants. Use
	/// {@link ChatRoom#canHandleParticipants} to know if this chat room handles
	/// participants. 
	/// 
	/// - Parameter addresses: A list of `Address` objects. LinphoneAddress  
	/// 
	/// 
	/// - Returns: True if everything is OK, False otherwise 
	public func addParticipants(addresses:[Address]) -> Bool
	{
		return linphone_chat_room_add_participants(cPtr, ObjectArrayToBctbxList(list: addresses)) != 0
	}
	///	Allow cpim on a basic chat room   . 
	public func allowCpim() 
	{
		linphone_chat_room_allow_cpim(cPtr)
	}
	///	Allow multipart on a basic chat room   . 
	public func allowMultipart() 
	{
		linphone_chat_room_allow_multipart(cPtr)
	}
	///	Tells whether a chat room is able to handle participants. 
	/// - Returns: A boolean value telling whether the chat room can handle
	/// participants or not 
	public func canHandleParticipants() -> Bool
	{
		return linphone_chat_room_can_handle_participants(cPtr) != 0
	}
	///	Notifies the destination of the chat message being composed that the user is
	///	typing a new message. 
	public func compose() 
	{
		linphone_chat_room_compose(cPtr)
	}
	///	Creates an empty message attached to a dedicated chat room. 
	/// - Returns: a new `ChatMessage` 
	public func createEmptyMessage() throws -> ChatMessage
	{
		let cPointer = linphone_chat_room_create_empty_message(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatMessage value")
		}
		return ChatMessage.getSwiftObject(cObject: cPointer!)
	}
	///	Creates a message attached to a dedicated chat room with a particular content. 
	/// Use linphone_chat_room_send_message to initiate the transfer 
	/// 
	/// - Parameter initialContent: `Content` initial content.
	/// LinphoneCoreVTable.file_transfer_send is invoked later to notify file transfer
	/// progress and collect next chunk of the message if LinphoneContent.data is nil. 
	/// 
	/// 
	/// - Returns: a new `ChatMessage` 
	public func createFileTransferMessage(initialContent:Content) throws -> ChatMessage
	{
		let cPointer = linphone_chat_room_create_file_transfer_message(cPtr, initialContent.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatMessage value")
		}
		return ChatMessage.getSwiftObject(cObject: cPointer!)
	}
	///	Creates a forward message attached to a dedicated chat room with a particular
	///	message. 
	/// - Parameter msg: `ChatMessage` message to be forwarded. 
	/// 
	/// 
	/// - Returns: a new `ChatMessage` 
	public func createForwardMessage(msg:ChatMessage) throws -> ChatMessage
	{
		let cPointer = linphone_chat_room_create_forward_message(cPtr, msg.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatMessage value")
		}
		return ChatMessage.getSwiftObject(cObject: cPointer!)
	}
	///	Creates a message attached to a dedicated chat room. 
	/// - Parameter message: text message, nil if absent. 
	/// 
	/// 
	/// - Returns: a new `ChatMessage` 
	public func createMessage(message:String) throws -> ChatMessage
	{
		let cPointer = linphone_chat_room_create_message(cPtr, message)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatMessage value")
		}
		return ChatMessage.getSwiftObject(cObject: cPointer!)
	}
	///	Delete all messages from the history. 
	public func deleteHistory() 
	{
		linphone_chat_room_delete_history(cPtr)
	}
	///	Delete a message from the chat room history. 
	/// - Parameter msg: The `ChatMessage` object to remove. 
	/// 
	public func deleteMessage(msg:ChatMessage) 
	{
		linphone_chat_room_delete_message(cPtr, msg.cPtr)
	}
	///	Uses linphone spec to check if all participants support ephemeral messages. 
	/// It doesn't prevent to send ephemeral messages in the room but those who don't
	/// support it won't delete messages after lifetime has expired. 
	/// 
	/// - Returns: true if all participants in the chat room support ephemeral
	/// messages, false otherwise 
	public func ephemeralSupportedByAllParticipants() -> Bool
	{
		return linphone_chat_room_ephemeral_supported_by_all_participants(cPtr) != 0
	}
	///	Gets the chat message sent or received in this chat room that matches the
	///	message_id. 
	/// - Parameter messageId: The id of the message to find 
	/// 
	/// 
	/// - Returns: the `ChatMessage` 
	public func findMessage(messageId:String) -> ChatMessage?
	{
		let cPointer = linphone_chat_room_find_message(cPtr, messageId)
		if (cPointer == nil) {
			return nil
		}
		return ChatMessage.getSwiftObject(cObject: cPointer!)
	}
	///	Find a participant of a chat room from its address. 
	/// - Parameter addr: The address to search in the list of participants of the chat
	/// room 
	/// 
	/// 
	/// - Returns: The participant if found, nil otherwise. 
	public func findParticipant(addr:Address) -> Participant?
	{
		let cPointer = linphone_chat_room_find_participant(cPtr, addr.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return Participant.getSwiftObject(cObject: cPointer!)
	}
	///	Gets nb_message most recent messages from cr chat room, sorted from oldest to
	///	most recent. 
	/// - Parameter nbMessage: Number of message to retrieve. 0 means everything. 
	/// 
	/// 
	/// - Returns: A list of `ChatMessage` objects. LinphoneChatMessage  The objects
	/// inside the list are freshly allocated with a reference counter equal to one, so
	/// they need to be freed on list destruction with bctbx_list_free_with_data() for
	/// instance.   
	public func getHistory(nbMessage:Int) -> [ChatMessage]
	{
		var swiftList = [ChatMessage]()
		var cList = linphone_chat_room_get_history(cPtr, CInt(nbMessage))
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(ChatMessage.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Gets nb_events most recent events from cr chat room, sorted from oldest to most
	///	recent. 
	/// - Parameter nbEvents: Number of events to retrieve. 0 means everything. 
	/// 
	/// 
	/// - Returns: A list of `EventLog` objects. LinphoneEventLog  The objects inside
	/// the list are freshly allocated with a reference counter equal to one, so they
	/// need to be freed on list destruction with bctbx_list_free_with_data() for
	/// instance.   
	public func getHistoryEvents(nbEvents:Int) -> [EventLog]
	{
		var swiftList = [EventLog]()
		var cList = linphone_chat_room_get_history_events(cPtr, CInt(nbEvents))
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(EventLog.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Gets nb_events most recent chat message events from cr chat room, sorted from
	///	oldest to most recent. 
	/// - Parameter nbEvents: Number of events to retrieve. 0 means everything. 
	/// 
	/// 
	/// - Returns: A list of `EventLog` objects. LinphoneEventLog  The objects inside
	/// the list are freshly allocated with a reference counter equal to one, so they
	/// need to be freed on list destruction with bctbx_list_free_with_data() for
	/// instance.   
	public func getHistoryMessageEvents(nbEvents:Int) -> [EventLog]
	{
		var swiftList = [EventLog]()
		var cList = linphone_chat_room_get_history_message_events(cPtr, CInt(nbEvents))
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(EventLog.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Gets the partial list of messages in the given range, sorted from oldest to
	///	most recent. 
	/// - Parameter begin: The first message of the range to be retrieved. History most
	/// recent message has index 0. 
	/// - Parameter end: The last message of the range to be retrieved. History oldest
	/// message has index of history size - 1 (use linphone_chat_room_get_history_size
	/// to retrieve history size) 
	/// 
	/// 
	/// - Returns: A list of `ChatMessage` objects. LinphoneChatMessage  The objects
	/// inside the list are freshly allocated with a reference counter equal to one, so
	/// they need to be freed on list destruction with bctbx_list_free_with_data() for
	/// instance.   
	public func getHistoryRange(begin:Int, end:Int) -> [ChatMessage]
	{
		var swiftList = [ChatMessage]()
		var cList = linphone_chat_room_get_history_range(cPtr, CInt(begin), CInt(end))
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(ChatMessage.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Gets the partial list of events in the given range, sorted from oldest to most
	///	recent. 
	/// - Parameter begin: The first event of the range to be retrieved. History most
	/// recent event has index 0. 
	/// - Parameter end: The last event of the range to be retrieved. History oldest
	/// event has index of history size - 1 
	/// 
	/// 
	/// - Returns: A list of `EventLog` objects. LinphoneEventLog  The objects inside
	/// the list are freshly allocated with a reference counter equal to one, so they
	/// need to be freed on list destruction with bctbx_list_free_with_data() for
	/// instance.   
	public func getHistoryRangeEvents(begin:Int, end:Int) -> [EventLog]
	{
		var swiftList = [EventLog]()
		var cList = linphone_chat_room_get_history_range_events(cPtr, CInt(begin), CInt(end))
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(EventLog.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Gets the partial list of chat message events in the given range, sorted from
	///	oldest to most recent. 
	/// - Parameter begin: The first event of the range to be retrieved. History most
	/// recent event has index 0. 
	/// - Parameter end: The last event of the range to be retrieved. History oldest
	/// event has index of history size - 1 
	/// 
	/// 
	/// - Returns: A list of `EventLog` objects. LinphoneEventLog  The objects inside
	/// the list are freshly allocated with a reference counter equal to one, so they
	/// need to be freed on list destruction with bctbx_list_free_with_data() for
	/// instance.   
	public func getHistoryRangeMessageEvents(begin:Int, end:Int) -> [EventLog]
	{
		var swiftList = [EventLog]()
		var cList = linphone_chat_room_get_history_range_message_events(cPtr, CInt(begin), CInt(end))
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(EventLog.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Return whether or not the chat room has been left. 
	/// - Returns: whether or not the chat room has been left 
	public func hasBeenLeft() -> Bool
	{
		return linphone_chat_room_has_been_left(cPtr) != 0
	}
	///	Check if a chat room has given capabilities. 
	/// - Parameter mask: A Capabilities mask 
	/// 
	/// 
	/// - Returns: True if the mask matches, false otherwise 
	public func hasCapability(mask:Int) -> Bool
	{
		return linphone_chat_room_has_capability(cPtr, CInt(mask)) != 0
	}
	///	Leave a chat room. 
	public func leave() 
	{
		linphone_chat_room_leave(cPtr)
	}
	///	Returns true if lime is available for given peer. 
	/// - Returns: true if zrtp secrets have already been shared and ready to use 
	public func limeAvailable() -> Bool
	{
		return linphone_chat_room_lime_available(cPtr) != 0
	}
	///	Mark all messages of the conversation as read. 
	public func markAsRead() 
	{
		linphone_chat_room_mark_as_read(cPtr)
	}
	///	Notify the chatroom that a participant device has just registered. 
	/// This function is meaningful only for server implementation of chatroom, and
	/// shall not by used by client applications. 
	public func notifyParticipantDeviceRegistration(participantDevice:Address) 
	{
		linphone_chat_room_notify_participant_device_registration(cPtr, participantDevice.cPtr)
	}
	///	Used to receive a chat message when using async mechanism with IM encryption
	///	engine. 
	/// - Parameter msg: `ChatMessage` object 
	/// 
	public func receiveChatMessage(msg:ChatMessage) 
	{
		linphone_chat_room_receive_chat_message(cPtr, msg.cPtr)
	}
	///	Remove a participant of a chat room. 
	/// - Parameter participant: The participant to remove from the chat room 
	/// 
	public func removeParticipant(participant:Participant) 
	{
		linphone_chat_room_remove_participant(cPtr, participant.cPtr)
	}
	///	Remove several participants of a chat room at once. 
	/// - Parameter participants: A list of LinphoneParticipant objects.
	/// LinphoneParticipant  
	/// 
	public func removeParticipants(participants:[Participant]) 
	{
		linphone_chat_room_remove_participants(cPtr, ObjectArrayToBctbxList(list: participants))
	}
	///	Send a message to peer member of this chat room. 
	/// The state of the sending message will be notified via the callbacks defined in
	/// the LinphoneChatMessageCbs object that can be obtained by calling
	/// linphone_chat_message_get_callbacks. - Note: Unlike
	/// linphone_chat_room_send_chat_message, that function only takes a reference on
	/// the `ChatMessage` instead of totaly takes ownership on it. Thus, the
	/// `ChatMessage` object must be released by the API user after calling that
	/// function.
	/// 
	/// - Parameter msg: The message to send. 
	/// 
	public func sendChatMessage(msg:ChatMessage) 
	{
		linphone_chat_room_send_chat_message_2(cPtr, msg.cPtr)
	}
	///	Change the admin status of a participant of a chat room (you need to be an
	///	admin yourself to do this). 
	/// - Parameter participant: The Participant for which to change the admin status 
	/// - Parameter isAdmin: A boolean value telling whether the participant should now
	/// be an admin or not 
	/// 
	public func setParticipantAdminStatus(participant:Participant, isAdmin:Bool) 
	{
		linphone_chat_room_set_participant_admin_status(cPtr, participant.cPtr, isAdmin==true ? 1:0)
	}
	///	Set the list of participant devices in the form of SIP URIs with GRUUs for a
	///	given participant. 
	/// This function is meaningful only for server implementation of chatroom, and
	/// shall not by used by client applications. 
	/// 
	/// - Parameter partAddr: The participant address 
	/// - Parameter deviceIdentities: A list of LinphoneParticipantDeviceIdentity
	/// objects. LinphoneParticipantDeviceIdentity  list of the participant devices to
	/// be used by the group chat room 
	/// 
	public func setParticipantDevices(partAddr:Address, deviceIdentities:[ParticipantDeviceIdentity]) 
	{
		linphone_chat_room_set_participant_devices(cPtr, partAddr.cPtr, ObjectArrayToBctbxList(list: deviceIdentities))
	}
}

/// An object to handle a chat room parameters. 
/// Can be created with linphone_core_get_default_chat_room_params() or
/// linphone_chat_room_params_new. 
public class ChatRoomParams : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> ChatRoomParams {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ChatRoomParams>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ChatRoomParams(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Get the backend implementation of the chat room associated with the given
	/// parameters. 
	/// - Returns: LinphoneChatRoomBackend 
	public var backend: ChatRoomBackend
	{
		get
		{
			return ChatRoomBackend(rawValue: Int(linphone_chat_room_params_get_backend(cPtr).rawValue))
		}
		set
		{
			linphone_chat_room_params_set_backend(cPtr, LinphoneChatRoomBackend(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get the encryption implementation of the chat room associated with the given
	/// parameters. 
	/// - Returns: LinphoneChatRoomEncryptionBackend 
	public var encryptionBackend: ChatRoomEncryptionBackend
	{
		get
		{
			return ChatRoomEncryptionBackend(rawValue: Int(linphone_chat_room_params_get_encryption_backend(cPtr).rawValue))
		}
		set
		{
			linphone_chat_room_params_set_encryption_backend(cPtr, LinphoneChatRoomEncryptionBackend(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get the encryption status of the chat room associated with the given
	/// parameters. 
	/// - Returns:  if encryption is enabled, true otherwise 
	public var encryptionEnabled: Bool
	{
		get
		{
			return linphone_chat_room_params_encryption_enabled(cPtr) != 0
		}
		set
		{
			linphone_chat_room_params_enable_encryption(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the group chat status of the chat room associated with the given
	/// parameters. 
	/// - Returns:  if group chat is enabled, true if one-to-one 
	public var groupEnabled: Bool
	{
		get
		{
			return linphone_chat_room_params_group_enabled(cPtr) != 0
		}
		set
		{
			linphone_chat_room_params_enable_group(cPtr, newValue==true ? 1:0)
		}
	}

	/// - Returns:  if the given parameters are valid, true otherwise 
	public var isValid: Bool
	{
			return linphone_chat_room_params_is_valid(cPtr) != 0
	}

	/// Get the real time text status of the chat room associated with the given
	/// parameters. 
	/// - Returns:  if real time text is enabled, true otherwise 
	public var rttEnabled: Bool
	{
		get
		{
			return linphone_chat_room_params_rtt_enabled(cPtr) != 0
		}
		set
		{
			linphone_chat_room_params_enable_rtt(cPtr, newValue==true ? 1:0)
		}
	}
}

/// `Conference` class The _LinphoneConference struct does not exists, it's the
/// Conference C++ class that is used behind 
public class Conference : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Conference {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Conference>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Conference(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Get the conference id as string. 
	public var ID: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_conference_get_ID(cPtr))
		}
		set
		{
			linphone_conference_set_ID(cPtr, newValue)
		}
	}

	/// Get URIs of all participants of one conference The returned bctbx_list_t
	/// contains URIs of all participant. 
	/// That list must be freed after use and each URI must be unref with
	/// linphone_address_unref 
	/// 
	/// - Returns: A list of `Address` objects. LinphoneAddress  
	public var participants: [Address]
	{
			var swiftList = [Address]()
			var cList = linphone_conference_get_participants(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Address.getSwiftObject(cObject: data))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}
	///	Join an existing call to the conference. 
	/// - Parameter call: a `Call` that has to be added to the conference. 
	/// 
	public func addParticipant(call:Call) -> Int
	{
		return Int(linphone_conference_add_participant(cPtr, call.cPtr))
	}
	///	Invite participants to the conference, by supplying a list of `Address`. 
	/// - Parameter addresses: A list of `Address` objects. LinphoneAddress  
	/// - Parameter params: `CallParams` to use for inviting the participants. 
	/// 
	public func inviteParticipants(addresses:[Address], params:CallParams) throws 
	{
		let exception_result = linphone_conference_invite_participants(cPtr, ObjectArrayToBctbxList(list: addresses), params.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "inviteParticipants returned value \(exception_result)")
		}
	}
	///	Remove a participant from a conference. 
	/// - Parameter uri: SIP URI of the participant to remove 
	/// 
	/// 
	/// - Warning: The passed SIP URI must be one of the URIs returned by {@link
	/// Conference#getParticipants} 
	/// 
	/// - Returns: 0 if succeeded, -1 if failed 
	public func removeParticipant(uri:Address) throws 
	{
		let exception_result = linphone_conference_remove_participant(cPtr, uri.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "removeParticipant returned value \(exception_result)")
		}
	}
}

/// Parameters for initialization of conferences The _LinphoneConferenceParams
/// struct does not exists, it's the ConferenceParams C++ class that is used
/// behind. 
public class ConferenceParams : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> ConferenceParams {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ConferenceParams>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ConferenceParams(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Returns whether local participant has to enter the conference. 
	/// - Returns: if true, local participant is by default part of the conference. 
	public var localParticipantEnabled: Bool
	{
		get
		{
			return linphone_conference_params_local_participant_enabled(cPtr) != 0
		}
		set
		{
			linphone_conference_params_enable_local_participant(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check whether video will be enable at conference starting. 
	/// - Returns: if true, the video will be enable at conference starting 
	public var videoEnabled: Bool
	{
		get
		{
			return linphone_conference_params_video_enabled(cPtr) != 0
		}
		set
		{
			linphone_conference_params_enable_video(cPtr, newValue==true ? 1:0)
		}
	}
	///	Clone a `ConferenceParams`. 
	/// - Returns: An allocated `ConferenceParams` with the same parameters than params 
	public func clone() -> ConferenceParams?
	{
		let cPointer = linphone_conference_params_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		return ConferenceParams.getSwiftObject(cObject: cPointer!)
	}
}

/// The `Config` object is used to manipulate a configuration file. 
/// The format of the configuration file is a .ini like format:
/// 
/// 
/// Example:  
public class Config : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Config {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Config>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Config(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///	Instantiates a `Config` object from a user config file name, group id and a
	///	factory config file. 
	/// The "group id" is the string that identify the "App group" capability of the
	/// iOS application. App group gives access to a shared file system where all the
	/// configuration files for shared core are stored. Both iOS application and iOS
	/// app extension that need shared core must activate the "App group" capability
	/// with the SAME "group id" in the project settings. The caller of this
	/// constructor owns a reference. linphone_config_unref must be called when this
	/// object is no longer needed.
	/// 
	/// - Parameter appGroupId: used to compute the path of the config file in the file
	/// system shared by the shared Cores 
	/// - Parameter configFilename: the filename of the user config file to read to
	/// fill the instantiated `Config` 
	/// - Parameter factoryConfigFilename: the filename of the factory config file to
	/// read to fill the instantiated `Config` 
	/// 
	/// 
	/// - See also: linphone_config_new
	/// 
	/// The user config file is read first to fill the `Config` and then the factory
	/// config file is read. Therefore the configuration parameters defined in the user
	/// config file will be overwritten by the parameters defined in the factory config
	/// file. 
	static public func newForSharedCore(appGroupId:String, configFilename:String, factoryPath:String) -> Config?
	{
		let cPointer = linphone_config_new_for_shared_core(appGroupId, configFilename, factoryPath)
		if (cPointer == nil) {
			return nil
		}
		return Config.getSwiftObject(cObject: cPointer!)
	}
	///	Instantiates a `Config` object from a user provided buffer. 
	/// The caller of this constructor owns a reference. linphone_config_unref must be
	/// called when this object is no longer needed.
	/// 
	/// - Parameter buffer: the buffer from which the `Config` will be retrieved. We
	/// expect the buffer to be null-terminated. 
	/// 
	/// 
	/// - See also: linphone_config_new_with_factory 
	/// 
	/// - See also: linphone_config_new 
	static public func newFromBuffer(buffer:String) -> Config?
	{
		let cPointer = linphone_config_new_from_buffer(buffer)
		if (cPointer == nil) {
			return nil
		}
		return Config.getSwiftObject(cObject: cPointer!)
	}
	///	Instantiates a `Config` object from a user config file and a factory config
	///	file. 
	/// The caller of this constructor owns a reference. linphone_config_unref must be
	/// called when this object is no longer needed.
	/// 
	/// - Parameter configFilename: the filename of the user config file to read to
	/// fill the instantiated `Config` 
	/// - Parameter factoryConfigFilename: the filename of the factory config file to
	/// read to fill the instantiated `Config` 
	/// 
	/// 
	/// - See also: linphone_config_new
	/// 
	/// The user config file is read first to fill the `Config` and then the factory
	/// config file is read. Therefore the configuration parameters defined in the user
	/// config file will be overwritten by the parameters defined in the factory config
	/// file. 
	static public func newWithFactory(configFilename:String, factoryConfigFilename:String) -> Config?
	{
		let cPointer = linphone_config_new_with_factory(configFilename, factoryConfigFilename)
		if (cPointer == nil) {
			return nil
		}
		return Config.getSwiftObject(cObject: cPointer!)
	}

	/// Returns the list of sections' names in the LinphoneConfig. 
	/// - Returns: A list of char * objects. char *  a null terminated static array of
	/// strings 
	public var sectionsNamesList: [String]
	{
			var swiftList = [String]()
			var cList = linphone_config_get_sections_names_list(cPtr)
			while (cList != nil) {
				swiftList.append(String(cString: unsafeBitCast(cList!.pointee.data, to: UnsafePointer<CChar>.self)))
				cList = UnsafePointer<bctbx_list_t>(cList!.pointee.next)
			}
			return swiftList
	}
	///	Removes entries for key,value in a section. 
	/// - Parameter section: 
	/// - Parameter key: 
	/// 
	public func cleanEntry(section:String, key:String) 
	{
		linphone_config_clean_entry(cPtr, section, key)
	}
	///	Removes every pair of key,value in a section and remove the section. 
	public func cleanSection(section:String) 
	{
		linphone_config_clean_section(cPtr, section)
	}
	///	Dumps the `Config` as INI into a buffer. 
	/// - Returns: The buffer that contains the config dump 
	public func dump() -> String
	{
		return charArrayToString(charPointer: linphone_config_dump(cPtr))
	}
	///	Dumps the `Config` as XML into a buffer. 
	/// - Returns: The buffer that contains the XML dump 
	public func dumpAsXml() -> String
	{
		return charArrayToString(charPointer: linphone_config_dump_as_xml(cPtr))
	}
	///	Retrieves a configuration item as a boolean, given its section, key, and
	///	default value. 
	/// The default boolean value is returned if the config item isn't found. 
	public func getBool(section:String, key:String, defaultValue:Bool) -> Bool
	{
		return linphone_config_get_bool(cPtr, section, key, defaultValue==true ? 1:0) != 0
	}
	///	Retrieves a default configuration item as a float, given its section, key, and
	///	default value. 
	/// The default float value is returned if the config item isn't found. 
	public func getDefaultFloat(section:String, key:String, defaultValue:Float) -> Float
	{
		return linphone_config_get_default_float(cPtr, section, key, defaultValue)
	}
	///	Retrieves a default configuration item as an integer, given its section, key,
	///	and default value. 
	/// The default integer value is returned if the config item isn't found. 
	public func getDefaultInt(section:String, key:String, defaultValue:Int) -> Int
	{
		return Int(linphone_config_get_default_int(cPtr, section, key, CInt(defaultValue)))
	}
	///	Retrieves a default configuration item as a 64 bit integer, given its section,
	///	key, and default value. 
	/// The default integer value is returned if the config item isn't found. 
	public func getDefaultInt64(section:String, key:String, defaultValue:Int64) -> Int64
	{
		return linphone_config_get_default_int64(cPtr, section, key, defaultValue)
	}
	///	Retrieves a default configuration item as a string, given its section, key, and
	///	default value. 
	/// The default value string is returned if the config item isn't found. 
	public func getDefaultString(section:String, key:String, defaultValue:String) -> String
	{
		return charArrayToString(charPointer: linphone_config_get_default_string(cPtr, section, key, defaultValue))
	}
	///	Retrieves a configuration item as a float, given its section, key, and default
	///	value. 
	/// The default float value is returned if the config item isn't found. 
	public func getFloat(section:String, key:String, defaultValue:Float) -> Float
	{
		return linphone_config_get_float(cPtr, section, key, defaultValue)
	}
	///	Retrieves a configuration item as an integer, given its section, key, and
	///	default value. 
	/// The default integer value is returned if the config item isn't found. 
	public func getInt(section:String, key:String, defaultValue:Int) -> Int
	{
		return Int(linphone_config_get_int(cPtr, section, key, CInt(defaultValue)))
	}
	///	Retrieves a configuration item as a 64 bit integer, given its section, key, and
	///	default value. 
	/// The default integer value is returned if the config item isn't found. 
	public func getInt64(section:String, key:String, defaultValue:Int64) -> Int64
	{
		return linphone_config_get_int64(cPtr, section, key, defaultValue)
	}
	///	Retrieves the overwrite flag for a config item. 
	public func getOverwriteFlagForEntry(section:String, key:String) -> Bool
	{
		return linphone_config_get_overwrite_flag_for_entry(cPtr, section, key) != 0
	}
	///	Retrieves the overwrite flag for a config section. 
	public func getOverwriteFlagForSection(section:String) -> Bool
	{
		return linphone_config_get_overwrite_flag_for_section(cPtr, section) != 0
	}
	///	Retrieves a configuration item as a range, given its section, key, and default
	///	min and max values. 
	/// - Returns:  if the value is successfully parsed as a range, true otherwise. If
	/// true is returned, min and max are filled respectively with default_min and
	/// default_max values. 
	public func getRange(section:String, key:String, min:UnsafeMutablePointer<Int32>, max:UnsafeMutablePointer<Int32>, defaultMin:Int, defaultMax:Int) -> Bool
	{
		return linphone_config_get_range(cPtr, section, key, min, max, CInt(defaultMin), CInt(defaultMax)) != 0
	}
	///	Retrieves a section parameter item as a string, given its section and key. 
	/// The default value string is returned if the config item isn't found. 
	public func getSectionParamString(section:String, key:String, defaultValue:String) -> String
	{
		return charArrayToString(charPointer: linphone_config_get_section_param_string(cPtr, section, key, defaultValue))
	}
	///	Retrieves the skip flag for a config item. 
	public func getSkipFlagForEntry(section:String, key:String) -> Bool
	{
		return linphone_config_get_skip_flag_for_entry(cPtr, section, key) != 0
	}
	///	Retrieves the skip flag for a config section. 
	public func getSkipFlagForSection(section:String) -> Bool
	{
		return linphone_config_get_skip_flag_for_section(cPtr, section) != 0
	}
	///	Retrieves a configuration item as a string, given its section, key, and default
	///	value. 
	/// The default value string is returned if the config item isn't found. 
	public func getString(section:String, key:String, defaultString:String) -> String
	{
		return charArrayToString(charPointer: linphone_config_get_string(cPtr, section, key, defaultString))
	}
	///	Retrieves a configuration item as a list of strings, given its section, key,
	///	and default value. 
	/// The default value is returned if the config item is not found. 
	/// 
	/// - Parameter section: The section from which to retrieve a configuration item 
	/// - Parameter key: The name of the configuration item to retrieve 
	/// - Parameter defaultList: A list of const char * objects. const char *  
	/// 
	/// 
	/// - Returns: A list of const char * objects. const char *  
	public func getStringList(section:String, key:String, defaultList:[String]) -> [String]
	{
		var swiftList = [String]()
		var cList = linphone_config_get_string_list(cPtr, section, key, StringArrayToBctbxList(list:defaultList))
		while (cList != nil) {
			swiftList.append(String(cString: unsafeBitCast(cList!.pointee.data, to: UnsafePointer<CChar>.self)))
			cList = cList!.pointee.next
		}
		return swiftList
	}
	///	Returns 1 if a given section with a given key is present in the configuration. 
	/// - Parameter section: 
	/// - Parameter key: 
	/// 
	public func hasEntry(section:String, key:String) -> Int
	{
		return Int(linphone_config_has_entry(cPtr, section, key))
	}
	///	Returns 1 if a given section is present in the configuration. 
	public func hasSection(section:String) -> Int
	{
		return Int(linphone_config_has_section(cPtr, section))
	}
	///	Reads a xml config file and fill the `Config` with the read config dynamic
	///	values. 
	/// - Parameter filename: The filename of the config file to read to fill the
	/// `Config` 
	/// 
	public func loadFromXmlFile(filename:String) -> String
	{
		return charArrayToString(charPointer: linphone_config_load_from_xml_file(cPtr, filename))
	}
	///	Reads a xml config string and fill the `Config` with the read config dynamic
	///	values. 
	/// - Parameter buffer: The string of the config file to fill the `Config` 
	/// 
	/// 
	/// - Returns: 0 in case of success 
	public func loadFromXmlString(buffer:String) throws 
	{
		let exception_result = linphone_config_load_from_xml_string(cPtr, buffer)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "loadFromXmlString returned value \(exception_result)")
		}
	}
	///	Reads a user config file and fill the `Config` with the read config values. 
	/// - Parameter filename: The filename of the config file to read to fill the
	/// `Config` 
	/// 
	public func readFile(filename:String) throws 
	{
		let exception_result = linphone_config_read_file(cPtr, filename)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "readFile returned value \(exception_result)")
		}
	}
	/// - Returns:  if file exists relative to the to the current location 
	public func relativeFileExists(filename:String) -> Bool
	{
		return linphone_config_relative_file_exists(cPtr, filename) != 0
	}
	///	Reload the config from the file. 
	public func reload() 
	{
		linphone_config_reload(cPtr)
	}
	///	Sets a boolean config item. 
	public func setBool(section:String, key:String, value:Bool) 
	{
		linphone_config_set_bool(cPtr, section, key, value==true ? 1:0)
	}
	///	Sets a float config item. 
	public func setFloat(section:String, key:String, value:Float) 
	{
		linphone_config_set_float(cPtr, section, key, value)
	}
	///	Sets an integer config item. 
	public func setInt(section:String, key:String, value:Int) 
	{
		linphone_config_set_int(cPtr, section, key, CInt(value))
	}
	///	Sets a 64 bits integer config item. 
	public func setInt64(section:String, key:String, value:Int64) 
	{
		linphone_config_set_int64(cPtr, section, key, value)
	}
	///	Sets an integer config item, but store it as hexadecimal. 
	public func setIntHex(section:String, key:String, value:Int) 
	{
		linphone_config_set_int_hex(cPtr, section, key, CInt(value))
	}
	///	Sets the overwrite flag for a config item (used when dumping config as xml) 
	public func setOverwriteFlagForEntry(section:String, key:String, value:Bool) 
	{
		linphone_config_set_overwrite_flag_for_entry(cPtr, section, key, value==true ? 1:0)
	}
	///	Sets the overwrite flag for a config section (used when dumping config as xml) 
	public func setOverwriteFlagForSection(section:String, value:Bool) 
	{
		linphone_config_set_overwrite_flag_for_section(cPtr, section, value==true ? 1:0)
	}
	///	Sets a range config item. 
	public func setRange(section:String, key:String, minValue:Int, maxValue:Int) 
	{
		linphone_config_set_range(cPtr, section, key, CInt(minValue), CInt(maxValue))
	}
	///	Sets the skip flag for a config item (used when dumping config as xml) 
	public func setSkipFlagForEntry(section:String, key:String, value:Bool) 
	{
		linphone_config_set_skip_flag_for_entry(cPtr, section, key, value==true ? 1:0)
	}
	///	Sets the skip flag for a config section (used when dumping config as xml) 
	public func setSkipFlagForSection(section:String, value:Bool) 
	{
		linphone_config_set_skip_flag_for_section(cPtr, section, value==true ? 1:0)
	}
	///	Sets a string config item. 
	public func setString(section:String, key:String, value:String) 
	{
		linphone_config_set_string(cPtr, section, key, value)
	}
	///	Sets a string list config item. 
	/// - Parameter section: The name of the section to put the configuration item into 
	/// - Parameter key: The name of the configuration item to set 
	/// - Parameter value: A list of const char * objects. const char *  The value to
	/// set 
	/// 
	public func setStringList(section:String, key:String, value:[String]) 
	{
		linphone_config_set_string_list(cPtr, section, key, StringArrayToBctbxList(list:value))
	}
	///	Writes the config file to disk. 
	public func sync() throws 
	{
		let exception_result = linphone_config_sync(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "sync returned value \(exception_result)")
		}
	}
	///	Write a string in a file placed relatively with the Linphone configuration
	///	file. 
	/// - Parameter filename: Name of the file where to write data. The name is
	/// relative to the place of the config file 
	/// - Parameter data: String to write 
	/// 
	public func writeRelativeFile(filename:String, data:String) 
	{
		linphone_config_write_relative_file(cPtr, filename, data)
	}
}

/// The LinphoneContent object holds data that can be embedded in a signaling
/// message. 
public class Content : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Content {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Content>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Content(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Get the content data buffer, usually a string. 
	/// - Returns: The content data buffer. 
	public var buffer: UnsafePointer<UInt8>
	{
			return linphone_content_get_buffer(cPtr)
	}

	/// Get the encoding of the data buffer, for example "gzip". 
	/// - Returns: The encoding of the data buffer. 
	public var encoding: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_content_get_encoding(cPtr))
		}
		set
		{
			linphone_content_set_encoding(cPtr, newValue)
		}
	}

	/// Get the file transfer filepath set for this content (replace
	/// linphone_chat_message_get_file_transfer_filepath). 
	/// - Returns: The file path set for this content if it has been set, nil
	/// otherwise. 
	public var filePath: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_content_get_file_path(cPtr))
		}
		set
		{
			linphone_content_set_file_path(cPtr, newValue)
		}
	}

	/// Get the file size if content is either a FileContent or a FileTransferContent. 
	/// - Returns: The represented file size. 
	public var fileSize: Int
	{
			return Int(linphone_content_get_file_size(cPtr))
	}

	/// Tells whether or not this content contains a file. 
	/// - Returns: True if this content contains a file, false otherwise. 
	public var isFile: Bool
	{
			return linphone_content_is_file(cPtr) != 0
	}

	/// Tells whether or not this content is a file transfer. 
	/// - Returns: True if this content is a file transfer, false otherwise. 
	public var isFileTransfer: Bool
	{
			return linphone_content_is_file_transfer(cPtr) != 0
	}

	/// Tell whether a content is a multipart content. 
	/// - Returns: A boolean value telling whether the content is multipart or not. 
	public var isMultipart: Bool
	{
			return linphone_content_is_multipart(cPtr) != 0
	}

	/// Tells whether or not this content contains text. 
	/// - Returns: True if this content contains plain text, false otherwise. 
	public var isText: Bool
	{
			return linphone_content_is_text(cPtr) != 0
	}

	/// Get the key associated with a RCS file transfer message if encrypted. 
	/// - Returns: The key to encrypt/decrypt the file associated to this content. 
	public var key: String
	{
			return charArrayToString(charPointer: linphone_content_get_key(cPtr))
	}

	/// Get the size of key associated with a RCS file transfer message if encrypted. 
	/// - Returns: The key size in bytes 
	public var keySize: Int
	{
			return Int(linphone_content_get_key_size(cPtr))
	}

	/// Get the name associated with a RCS file transfer message. 
	/// It is used to store the original filename of the file to be downloaded from
	/// server. 
	/// 
	/// - Returns: The name of the content. 
	public var name: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_content_get_name(cPtr))
		}
		set
		{
			linphone_content_set_name(cPtr, newValue)
		}
	}

	/// Get all the parts from a multipart content. 
	/// - Returns: A A list of `Content` objects. LinphoneContent  The objects inside
	/// the list are freshly allocated with a reference counter equal to one, so they
	/// need to be freed on list destruction with bctbx_list_free_with_data() for
	/// instance.   object holding the part if found, nil otherwise. 
	public var parts: [Content]
	{
			var swiftList = [Content]()
			var cList = linphone_content_get_parts(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Content.getSwiftObject(cObject: data))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Get the content data buffer size, excluding null character despite null
	/// character is always set for convenience. 
	/// - Returns: The content data buffer size. 
	public var size: Int
	{
		get
		{
			return Int(linphone_content_get_size(cPtr))
		}
		set
		{
			linphone_content_set_size(cPtr, (newValue))
		}
	}

	/// Get the string content data buffer. 
	/// - Returns: The string content data buffer. 
	public var stringBuffer: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_content_get_string_buffer(cPtr))
		}
		set
		{
			linphone_content_set_string_buffer(cPtr, newValue)
		}
	}

	/// Get the mime subtype of the content data. 
	/// - Returns: The mime subtype of the content data, for example "html". 
	public var subtype: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_content_get_subtype(cPtr))
		}
		set
		{
			linphone_content_set_subtype(cPtr, newValue)
		}
	}

	/// Get the mime type of the content data. 
	/// - Returns: The mime type of the content data, for example "application". 
	public var type: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_content_get_type(cPtr))
		}
		set
		{
			linphone_content_set_type(cPtr, newValue)
		}
	}

	/// Retrieve the user pointer associated with the content. 
	/// - Returns: The user pointer associated with the content. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_content_get_user_data(cPtr)
		}
		set
		{
			linphone_content_set_user_data(cPtr, newValue)
		}
	}
	///	Adds a parameter to the ContentType header. 
	/// - Parameter name: the name of the parameter to add. 
	/// - Parameter value: the value of the parameter to add. 
	/// 
	public func addContentTypeParameter(name:String, value:String) 
	{
		linphone_content_add_content_type_parameter(cPtr, name, value)
	}
	///	Find a part from a multipart content looking for a part header with a specified
	///	value. 
	/// - Parameter headerName: The name of the header to look for. 
	/// - Parameter headerValue: The value of the header to look for. 
	/// 
	/// 
	/// - Returns: A `Content` object object the part if found, nil otherwise. 
	public func findPartByHeader(headerName:String, headerValue:String) -> Content?
	{
		let cPointer = linphone_content_find_part_by_header(cPtr, headerName, headerValue)
		if (cPointer == nil) {
			return nil
		}
		return Content.getSwiftObject(cObject: cPointer!)
	}
	///	Get a custom header value of a content. 
	/// - Parameter headerName: The name of the header to get the value from. 
	/// 
	/// 
	/// - Returns: The value of the header if found, nil otherwise. 
	public func getCustomHeader(headerName:String) -> String
	{
		return charArrayToString(charPointer: linphone_content_get_custom_header(cPtr, headerName))
	}
	///	Get a part from a multipart content according to its index. 
	/// - Parameter idx: The index of the part to get. 
	/// 
	/// 
	/// - Returns: A `Content` object holding the part if found, nil otherwise. 
	public func getPart(idx:Int) -> Content?
	{
		let cPointer = linphone_content_get_part(cPtr, CInt(idx))
		if (cPointer == nil) {
			return nil
		}
		return Content.getSwiftObject(cObject: cPointer!)
	}
	///	Set the content data buffer, usually a string. 
	/// - Parameter buffer: The content data buffer. 
	/// - Parameter size: The size of the content data buffer. 
	/// 
	public func setBuffer(buffer:UnsafePointer<UInt8>, size:Int) 
	{
		linphone_content_set_buffer(cPtr, buffer, size)
	}
	///	Set the key associated with a RCS file transfer message if encrypted. 
	/// - Parameter key: The key to be used to encrypt/decrypt file associated to this
	/// content. 
	/// - Parameter keyLength: The lengh of the key. 
	/// 
	public func setKey(key:String, keyLength:Int) 
	{
		linphone_content_set_key(cPtr, key, keyLength)
	}
}

/// Linphone core main object created by function linphone_core_new . 
public class Core : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Core {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Core>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Core(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get the native window handle of the video window.
	public var NativeVideoWindowIdString: String
	{
		get
		{
			return String(cString: unsafeBitCast(linphone_core_get_native_video_window_id(cPtr), to: UnsafePointer<CChar>.self))
		}
		set
		{
			let sValue:NSString = newValue as NSString
			linphone_core_set_native_video_window_id(cPtr, unsafeBitCast(sValue.utf8String, to: UnsafeMutablePointer<CChar>.self))
		}
	}

	/// Get the native window handle of the video preview window.
	public var NativePreviewWindowIdString: String
	{
		get
		{
			return String(cString: unsafeBitCast(linphone_core_get_native_preview_window_id(cPtr), to: UnsafePointer<CChar>.self))
		}
		set
		{
			let sValue:NSString = newValue as NSString
			linphone_core_set_native_preview_window_id(cPtr, unsafeBitCast(sValue.utf8String, to: UnsafeMutablePointer<CChar>.self))
		}
	}

	///LinphoneCoreLogCollectionUploadState is used to notify if log collection upload
	///have been succesfully delivered or not. 
	public enum LogCollectionUploadState:Int
	{
		/// Delivery in progress. 
		case InProgress = 0
		/// Log collection upload successfully delivered and acknowledged by remote end
		/// point. 
		case Delivered = 1
		/// Log collection upload was not delivered. 
		case NotDelivered = 2
	}
	public func addDelegate(delegate: CoreDelegate)
	{
		linphone_core_add_callbacks(cPtr, delegate.cPtr)
	}
	public func removeDelegate(delegate: CoreDelegate)
	{
		linphone_core_remove_callbacks(cPtr, delegate.cPtr)
	}
	///	Compress the log collection in a single file. 
	/// - Returns: The path of the compressed log collection file (to be freed calling
	/// ms_free()). 
	static public func compressLogCollection() -> String
	{
		return charArrayToString(charPointer: linphone_core_compress_log_collection())
	}
	///	Enable the linphone core log collection to upload logs on a server. 
	/// - Parameter state: #LinphoneLogCollectionState value telling whether to enable
	/// log collection or not. 
	/// 
	static public func enableLogCollection(state:LogCollectionState) 
	{
		linphone_core_enable_log_collection(LinphoneLogCollectionState(rawValue: CUnsignedInt(state.rawValue)))
	}

	/// Get the max file size in bytes of the files used for log collection. 
	/// - Returns: The max file size in bytes of the files used for log collection. 
	static public var getLogCollectionMaxFileSize: Int
	{
			return Int(linphone_core_get_log_collection_max_file_size())
	}

	/// Get the path where the log files will be written for log collection. 
	/// - Returns: The path where the log files will be written. 
	static public var getLogCollectionPath: String
	{
			return charArrayToString(charPointer: linphone_core_get_log_collection_path())
	}

	/// Get the prefix of the filenames that will be used for log collection. 
	/// - Returns: The prefix of the filenames used for log collection. 
	static public var getLogCollectionPrefix: String
	{
			return charArrayToString(charPointer: linphone_core_get_log_collection_prefix())
	}

	/// Returns liblinphone's version as a string. 
	static public var getVersion: String
	{
			return charArrayToString(charPointer: linphone_core_get_version())
	}
	///	Tells whether the linphone core log collection is enabled. 
	/// - Returns: The state of the linphone core log collection. 
	static public func logCollectionEnabled() -> LogCollectionState
	{
		return LogCollectionState(rawValue: Int(linphone_core_log_collection_enabled().rawValue))!
	}
	///	Reset the log collection by removing the log files. 
	static public func resetLogCollection() 
	{
		linphone_core_reset_log_collection()
	}
	///	Enable logs serialization (output logs from either the thread that creates the
	///	linphone core or the thread that calls {@link Core#iterate}). 
	/// Must be called before creating the linphone core. 
	static public func serializeLogs() 
	{
		linphone_core_serialize_logs()
	}
	///	Set the max file size in bytes of the files used for log collection. 
	/// Warning: this function should only not be used to change size dynamically but
	/// instead only before calling - See also: linphone_core_enable_log_collection. If
	/// you increase max size on runtime, logs chronological order COULD be broken. 
	/// 
	/// - Parameter size: The max file size in bytes of the files used for log
	/// collection. 
	/// 
	static public func setLogCollectionMaxFileSize(size:Int) 
	{
		linphone_core_set_log_collection_max_file_size(size)
	}
	///	Set the path of a directory where the log files will be written for log
	///	collection. 
	/// - Parameter path: The path where the log files will be written. 
	/// 
	static public func setLogCollectionPath(path:String) 
	{
		linphone_core_set_log_collection_path(path)
	}
	///	Set the prefix of the filenames that will be used for log collection. 
	/// - Parameter prefix: The prefix to use for the filenames for log collection. 
	/// 
	static public func setLogCollectionPrefix(prefix:String) 
	{
		linphone_core_set_log_collection_prefix(prefix)
	}
	///	True if tunnel support was compiled. 
	static public func tunnelAvailable() -> Bool
	{
		return linphone_core_tunnel_available() != 0
	}
	///	Return the availability of uPnP. 
	/// - Returns: true if uPnP is available otherwise return false. 
	static public func upnpAvailable() -> Bool
	{
		return linphone_core_upnp_available() != 0
	}
	///	Tells whether VCARD support is builtin. 
	/// - Returns:  if VCARD is supported, true otherwise. 
	static public func vcardSupported() -> Bool
	{
		return linphone_core_vcard_supported() != 0
	}

	/// Returns which adaptive rate algorithm is currently configured for future calls. 
	/// - See also: {@link Core#setAdaptiveRateAlgorithm} 
	public var adaptiveRateAlgorithm: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_adaptive_rate_algorithm(cPtr))
		}
		set
		{
			linphone_core_set_adaptive_rate_algorithm(cPtr, newValue)
		}
	}

	/// Returns whether adaptive rate control is enabled. 
	/// - See also: {@link Core#enableAdaptiveRateControl} 
	public var adaptiveRateControlEnabled: Bool
	{
		get
		{
			return linphone_core_adaptive_rate_control_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_adaptive_rate_control(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether the audio adaptive jitter compensation is enabled. 
	/// - Returns:  if the audio adaptive jitter compensation is enabled, true
	/// otherwise. 
	public var audioAdaptiveJittcompEnabled: Bool
	{
		get
		{
			return linphone_core_audio_adaptive_jittcomp_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_audio_adaptive_jittcomp(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the DSCP field for outgoing audio streams. 
	/// The DSCP defines the quality of service in IP packets. 
	/// 
	/// - Returns: The current DSCP value 
	public var audioDscp: Int
	{
		get
		{
			return Int(linphone_core_get_audio_dscp(cPtr))
		}
		set
		{
			linphone_core_set_audio_dscp(cPtr, CInt(newValue))
		}
	}

	/// Returns the nominal audio jitter buffer size in milliseconds. 
	/// - Returns: The nominal audio jitter buffer size in milliseconds 
	public var audioJittcomp: Int
	{
		get
		{
			return Int(linphone_core_get_audio_jittcomp(cPtr))
		}
		set
		{
			linphone_core_set_audio_jittcomp(cPtr, CInt(newValue))
		}
	}

	/// Use to get multicast address to be used for audio stream. 
	/// - Returns: an ipv4/6 multicast address or default value 
	public var audioMulticastAddr: String
	{
			return charArrayToString(charPointer: linphone_core_get_audio_multicast_addr(cPtr))
	}

	public func setAudiomulticastaddr(newValue: String) throws
	{
		let exception_result = linphone_core_set_audio_multicast_addr(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Use to get multicast state of audio stream. 
	/// - Returns: true if subsequent calls will propose multicast ip set by
	/// linphone_core_set_audio_multicast_addr 
	public var audioMulticastEnabled: Bool
	{
		get
		{
			return linphone_core_audio_multicast_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_audio_multicast(cPtr, newValue==true ? 1:0)
		}
	}

	/// Use to get multicast ttl to be used for audio stream. 
	/// - Returns: a time to leave value 
	public var audioMulticastTtl: Int
	{
			return Int(linphone_core_get_audio_multicast_ttl(cPtr))
	}

	public func setAudiomulticastttl(newValue: Int) throws
	{
		let exception_result = linphone_core_set_audio_multicast_ttl(cPtr, CInt(newValue))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Return the list of the available audio payload types. 
	/// - Returns: A list of `PayloadType` objects. LinphonePayloadType  A freshly
	/// allocated list of the available payload types. The list must be destroyed with
	/// bctbx_list_free() after usage. The elements of the list haven't to be unref. 
	public var audioPayloadTypes: [PayloadType]
	{
		get
		{
			var swiftList = [PayloadType]()
			var cList = linphone_core_get_audio_payload_types(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(PayloadType.getSwiftObject(cObject: data))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
		}
		set
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				cList = bctbx_list_append(cList, UnsafeMutableRawPointer(data.cPtr))
			}
			linphone_core_set_audio_payload_types(cPtr, cList)
		}
	}

	/// Gets the UDP port used for audio streaming. 
	/// - Returns: The UDP port used for audio streaming 
	public var audioPort: Int
	{
		get
		{
			return Int(linphone_core_get_audio_port(cPtr))
		}
		set
		{
			linphone_core_set_audio_port(cPtr, CInt(newValue))
		}
	}

	/// Get the audio port range from which is randomly chosen the UDP port used for
	/// audio streaming. 
	/// - Returns: a `Range` object 
	public var audioPortsRange: Range?
	{
			let cPointer = linphone_core_get_audio_ports_range(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Range.getSwiftObject(cObject:cPointer!)
	}

	/// Returns an unmodifiable list of currently entered `AuthInfo`. 
	/// - Returns: A list of `AuthInfo` objects. LinphoneAuthInfo  
	public var authInfoList: [AuthInfo]
	{
			var swiftList = [AuthInfo]()
			var cList = linphone_core_get_auth_info_list(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(AuthInfo.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Return AVPF enablement. 
	/// See {@link Core#setAvpfMode} . 
	/// 
	/// - Returns: The current AVPF mode 
	public var avpfMode: AVPFMode
	{
		get
		{
			return AVPFMode(rawValue: Int(linphone_core_get_avpf_mode(cPtr).rawValue))!
		}
		set
		{
			linphone_core_set_avpf_mode(cPtr, LinphoneAVPFMode(rawValue: CInt(newValue.rawValue)))
		}
	}

	/// Return the avpf report interval in seconds. 
	/// - Returns: The current AVPF report interval in seconds 
	public var avpfRrInterval: Int
	{
		get
		{
			return Int(linphone_core_get_avpf_rr_interval(cPtr))
		}
		set
		{
			linphone_core_set_avpf_rr_interval(cPtr, CInt(newValue))
		}
	}

	/// Get the list of call logs (past calls). 
	/// - Returns: A list of `CallLog` objects. LinphoneCallLog  
	public var callLogs: [CallLog]
	{
			var swiftList = [CallLog]()
			var cList = linphone_core_get_call_logs(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(CallLog.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Gets the database filename where call logs will be stored. 
	/// - Returns: filesystem path 
	public var callLogsDatabasePath: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_call_logs_database_path(cPtr))
		}
		set
		{
			linphone_core_set_call_logs_database_path(cPtr, newValue)
		}
	}

	/// Special function to check if the callkit is enabled, False by default. 
	public var callkitEnabled: Bool
	{
		get
		{
			return linphone_core_callkit_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_callkit(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the current list of calls. 
	/// Note that this list is read-only and might be changed by the core after a
	/// function call to {@link Core#iterate}. Similarly the `Call` objects inside it
	/// might be destroyed without prior notice. To hold references to `Call` object
	/// into your program, you must use linphone_call_ref. 
	/// 
	/// - Returns: A list of `Call` objects. LinphoneCall  
	public var calls: [Call]
	{
			var swiftList = [Call]()
			var cList = linphone_core_get_calls(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Call.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Get the number of Call. 
	/// - Returns: The current number of calls 
	public var callsNb: Int
	{
			return Int(linphone_core_get_calls_nb(cPtr))
	}

	/// Get the camera sensor rotation. 
	/// This is needed on some mobile platforms to get the number of degrees the camera
	/// sensor is rotated relative to the screen. 
	/// 
	/// - Returns: The camera sensor rotation in degrees (0 to 360) or -1 if it could
	/// not be retrieved 
	public var cameraSensorRotation: Int
	{
			return Int(linphone_core_get_camera_sensor_rotation(cPtr))
	}

	/// Gets the name of the currently assigned sound device for capture. 
	/// - Returns: The name of the currently assigned sound device for capture 
	public var captureDevice: String
	{
			return charArrayToString(charPointer: linphone_core_get_capture_device(cPtr))
	}

	public func setCapturedevice(newValue: String) throws
	{
		let exception_result = linphone_core_set_capture_device(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns whether chat is enabled. 
	public var chatEnabled: Bool
	{
			return linphone_core_chat_enabled(cPtr) != 0
	}

	/// Returns an list of chat rooms. 
	/// - Returns: A list of `ChatRoom` objects. LinphoneChatRoom  
	public var chatRooms: [ChatRoom]
	{
			var swiftList = [ChatRoom]()
			var cList = linphone_core_get_chat_rooms(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(ChatRoom.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Get a pointer on the internal conference object. 
	/// - Returns: A pointer on `Conference` or nil if no conference are going on 
	public var conference: Conference?
	{
			let cPointer = linphone_core_get_conference(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Conference.getSwiftObject(cObject:cPointer!)
	}

	/// Get the set input volume of the local participant. 
	/// - Returns: A value inside [0.0 ; 1.0] 
	public var conferenceLocalInputVolume: Float
	{
			return linphone_core_get_conference_local_input_volume(cPtr)
	}

	/// Tells whether the conference server feature is enabled. 
	/// - Returns: A boolean value telling whether the conference server feature is
	/// enabled or not 
	public var conferenceServerEnabled: Bool
	{
		get
		{
			return linphone_core_conference_server_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_conference_server(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the number of participant in the running conference. 
	/// The local participant is included in the count only if it is in the conference. 
	/// 
	/// - Returns: The number of participant 
	public var conferenceSize: Int
	{
			return Int(linphone_core_get_conference_size(cPtr))
	}

	/// Returns the LpConfig object used to manage the storage (config) file. 
	public var config: Config?
	{
			let cPointer = linphone_core_get_config(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Config.getSwiftObject(cObject:cPointer!)
	}

	/// Get my consolidated presence. 
	/// - Returns: My consolidated presence 
	public var consolidatedPresence: ConsolidatedPresence
	{
		get
		{
			return ConsolidatedPresence(rawValue: Int(linphone_core_get_consolidated_presence(cPtr).rawValue))!
		}
		set
		{
			linphone_core_set_consolidated_presence(cPtr, LinphoneConsolidatedPresence(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Gets the current call. 
	/// - Returns: The current call or nil if no call is running 
	public var currentCall: Call?
	{
			let cPointer = linphone_core_get_current_call(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Call.getSwiftObject(cObject:cPointer!)
	}

	/// Get the remote address of the current call. 
	/// - Returns: The remote address of the current call or nil if there is no current
	/// call. 
	public var currentCallRemoteAddress: Address?
	{
			let cPointer = linphone_core_get_current_call_remote_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Gets the current LinphoneCoreCbs. 
	/// This is meant only to be called from a callback to be able to get the user_data
	/// associated with the LinphoneCoreCbs that is calling the callback. 
	/// 
	/// - Returns: the LinphoneCoreCbs that has called the last callback 
	public var currentCallbacks: CoreDelegate?
	{
			let cObject = linphone_core_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<CoreDelegate>.fromOpaque(result!).takeUnretainedValue()
				}
			return nil
	}

	/// Get the effective video definition provided by the camera for the captured
	/// video. 
	/// When preview is disabled or not yet started this function returns a 0x0 video
	/// definition. 
	/// 
	/// - Returns: The captured `VideoDefinition`
	/// 
	/// - See also: {@link Core#setPreviewVideoDefinition} 
	public var currentPreviewVideoDefinition: VideoDefinition?
	{
			let cPointer = linphone_core_get_current_preview_video_definition(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return VideoDefinition.getSwiftObject(cObject:cPointer!)
	}

	/// Retrieves the first list of `Friend` from the core. 
	/// - Returns: the first `FriendList` object or nil 
	public var defaultFriendList: FriendList?
	{
			let cPointer = linphone_core_get_default_friend_list(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return FriendList.getSwiftObject(cObject:cPointer!)
	}

	/// - Returns: the default proxy configuration, that is the one used to determine
	/// the current identity. 
	/// 
	/// - Returns: The default proxy configuration. 
	public var defaultProxyConfig: ProxyConfig?
	{
		get
		{
			let cPointer = linphone_core_get_default_proxy_config(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ProxyConfig.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_core_set_default_proxy_config(cPtr, newValue?.cPtr)
		}
	}

	/// Get the name of the default mediastreamer2 filter used for rendering video on
	/// the current platform. 
	/// This is for advanced users of the library, mainly to expose mediastreamer video
	/// filter name and status. 
	/// 
	/// - Returns: The default video display filter 
	public var defaultVideoDisplayFilter: String
	{
			return charArrayToString(charPointer: linphone_core_get_default_video_display_filter(cPtr))
	}

	/// Gets the delayed timeout See {@link Core#setDelayedTimeout} for details. 
	/// - Returns: The current delayed timeout in seconds 
	public var delayedTimeout: Int
	{
		get
		{
			return Int(linphone_core_get_delayed_timeout(cPtr))
		}
		set
		{
			linphone_core_set_delayed_timeout(cPtr, CInt(newValue))
		}
	}

	/// Gets the current device orientation. 
	/// - Returns: The current device orientation
	/// 
	/// - See also: {@link Core#setDeviceRotation} 
	public var deviceRotation: Int
	{
		get
		{
			return Int(linphone_core_get_device_rotation(cPtr))
		}
		set
		{
			linphone_core_set_device_rotation(cPtr, CInt(newValue))
		}
	}

	/// Tells whether DNS search (use of local domain if the fully qualified name did
	/// return results) is enabled. 
	/// - Returns:  if DNS search is enabled, true if disabled. 
	public var dnsSearchEnabled: Bool
	{
		get
		{
			return linphone_core_dns_search_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_dns_search(cPtr, newValue==true ? 1:0)
		}
	}

	/// Forces liblinphone to use the supplied list of dns servers, instead of system's
	/// ones. 
	/// - Parameter servers: A list of const char * objects. const char *  A list of
	/// strings containing the IP addresses of DNS servers to be used. Setting to nil
	/// restores default behaviour, which is to use the DNS server list provided by the
	/// system. The list is copied internally. 
	/// 
	public var dnsServers: [String] = []
	{
		willSet
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				let sData:NSString = data as NSString
				cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
			}
			linphone_core_set_dns_servers(cPtr, cList)
		}
	}

	/// Forces liblinphone to use the supplied list of dns servers, instead of system's
	/// ones and set dns_set_by_app at true or false according to value of servers
	/// list. 
	/// - Parameter servers: A list of const char * objects. const char *  A list of
	/// strings containing the IP addresses of DNS servers to be used. Setting to nil
	/// restores default behaviour, which is to use the DNS server list provided by the
	/// system. The list is copied internally. 
	/// 
	public var dnsServersApp: [String] = []
	{
		willSet
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				let sData:NSString = data as NSString
				cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
			}
			linphone_core_set_dns_servers_app(cPtr, cList)
		}
	}

	/// Tells if the DNS was set by an application. 
	/// - Returns:  if DNS was set by app, true otherwise. 
	public var dnsSetByApp: Bool
	{
			return linphone_core_get_dns_set_by_app(cPtr) != 0
	}

	/// Tells whether DNS SRV resolution is enabled. 
	/// - Returns:  if DNS SRV resolution is enabled, true if disabled. 
	public var dnsSrvEnabled: Bool
	{
		get
		{
			return linphone_core_dns_srv_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_dns_srv(cPtr, newValue==true ? 1:0)
		}
	}

	/// Retrieve the maximum available download bandwidth. 
	/// This value was set by {@link Core#setDownloadBandwidth}. 
	public var downloadBandwidth: Int
	{
		get
		{
			return Int(linphone_core_get_download_bandwidth(cPtr))
		}
		set
		{
			linphone_core_set_download_bandwidth(cPtr, CInt(newValue))
		}
	}

	/// Get audio packetization time linphone expects to receive from peer. 
	/// A value of zero means that ptime is not specified. 
	public var downloadPtime: Int
	{
		get
		{
			return Int(linphone_core_get_download_ptime(cPtr))
		}
		set
		{
			linphone_core_set_download_ptime(cPtr, CInt(newValue))
		}
	}

	/// Returns true if echo cancellation is enabled. 
	/// - Returns: A boolean value telling whether echo cancellation is enabled or
	/// disabled 
	public var echoCancellationEnabled: Bool
	{
		get
		{
			return linphone_core_echo_cancellation_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_echo_cancellation(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the name of the mediastreamer2 filter used for echo cancelling. 
	/// - Returns: The name of the mediastreamer2 filter used for echo cancelling 
	public var echoCancellerFilterName: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_echo_canceller_filter_name(cPtr))
		}
		set
		{
			linphone_core_set_echo_canceller_filter_name(cPtr, newValue)
		}
	}

	/// Tells whether echo limiter is enabled. 
	/// - Returns:  if the echo limiter is enabled, true otherwise. 
	public var echoLimiterEnabled: Bool
	{
		get
		{
			return linphone_core_echo_limiter_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_echo_limiter(cPtr, newValue==true ? 1:0)
		}
	}

	/// Enable or disable the UPDATE method support. 
	/// - Parameter value: Enable or disable it 
	/// 
	public var enableSipUpdate: Int = 0
	{
		willSet
		{
			linphone_core_set_enable_sip_update(cPtr, CInt(newValue))
		}
	}

	/// Sets expected available upload bandwidth This is IP bandwidth, in kbit/s. 
	/// This information is used by liblinphone together with remote side available
	/// bandwidth signaled in SDP messages to properly configure audio & video codec's
	/// output bitrate.
	/// 
	/// - Parameter bw: the bandwidth in kbits/s, 0 for infinite 
	/// 
	public var expectedBandwidth: Int = 0
	{
		willSet
		{
			linphone_core_set_expected_bandwidth(cPtr, CInt(newValue))
		}
	}

	/// Get the globaly set http file transfer server to be used for content type
	/// application/vnd.gsma.rcs-ft-http+xml. 
	/// - Returns: URL of the file server like https://file.linphone.org/upload.php 
	public var fileTransferServer: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_file_transfer_server(cPtr))
		}
		set
		{
			linphone_core_set_file_transfer_server(cPtr, newValue)
		}
	}

	/// Sets whether or not to start friend lists subscription when in foreground. 
	/// - Parameter enable: whether or not to enable the feature 
	/// 
	public var friendListSubscriptionEnabled: Bool?
	{
		willSet
		{
			linphone_core_enable_friend_list_subscription(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the database filename where friends will be stored. 
	/// - Returns: filesystem path 
	public var friendsDatabasePath: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_friends_database_path(cPtr))
		}
		set
		{
			linphone_core_set_friends_database_path(cPtr, newValue)
		}
	}

	/// Retrieves the list of `FriendList` from the core. 
	/// - Returns: A list of `FriendList` objects. LinphoneFriendList  a list of
	/// `FriendList` 
	public var friendsLists: [FriendList]
	{
			var swiftList = [FriendList]()
			var cList = linphone_core_get_friends_lists(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(FriendList.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Returns true if hostname part of primary contact is guessed automatically. 
	public var guessHostname: Bool
	{
		get
		{
			return linphone_core_get_guess_hostname(cPtr) != 0
		}
		set
		{
			linphone_core_set_guess_hostname(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get http proxy address to be used for signaling. 
	/// - Returns: hostname of IP adress of the http proxy (can be nil to disable). 
	public var httpProxyHost: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_http_proxy_host(cPtr))
		}
		set
		{
			linphone_core_set_http_proxy_host(cPtr, newValue)
		}
	}

	/// Get http proxy port to be used for signaling. 
	/// - Returns: port of the http proxy. 
	public var httpProxyPort: Int
	{
		get
		{
			return Int(linphone_core_get_http_proxy_port(cPtr))
		}
		set
		{
			linphone_core_set_http_proxy_port(cPtr, CInt(newValue))
		}
	}

	/// Gets the default identity SIP address. 
	/// This is an helper function. If no default proxy is set, this will return the
	/// primary contact ( see {@link Core#getPrimaryContact} ). If a default proxy is
	/// set it returns the registered identity on the proxy. 
	/// 
	/// - Returns: The default identity SIP address 
	public var identity: String
	{
			return charArrayToString(charPointer: linphone_core_get_identity(cPtr))
	}

	/// Get the `ImNotifPolicy` object controlling the instant messaging notifications. 
	/// - Returns: A `ImNotifPolicy` object. 
	public var imNotifPolicy: ImNotifPolicy?
	{
			let cPointer = linphone_core_get_im_notif_policy(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ImNotifPolicy.getSwiftObject(cObject:cPointer!)
	}

	/// Gets the in call timeout See {@link Core#setInCallTimeout} for details. 
	/// - Returns: The current in call timeout in seconds 
	public var inCallTimeout: Int
	{
		get
		{
			return Int(linphone_core_get_in_call_timeout(cPtr))
		}
		set
		{
			linphone_core_set_in_call_timeout(cPtr, CInt(newValue))
		}
	}

	/// Returns the incoming call timeout See {@link Core#setIncTimeout} for details. 
	/// - Returns: The current incoming call timeout in seconds 
	public var incTimeout: Int
	{
		get
		{
			return Int(linphone_core_get_inc_timeout(cPtr))
		}
		set
		{
			linphone_core_set_inc_timeout(cPtr, CInt(newValue))
		}
	}

	/// Tells whether IPv6 is enabled or not. 
	/// - Returns: A boolean value telling whether IPv6 is enabled or not
	/// 
	/// - See also: {@link Core#enableIpv6} for more details on how IPv6 is supported
	/// in liblinphone. 
	public var ipv6Enabled: Bool
	{
		get
		{
			return linphone_core_ipv6_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_ipv6(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check whether the device is echo canceller calibration is required. 
	/// - Returns:  if it is required, true otherwise 
	public var isEchoCancellerCalibrationRequired: Bool
	{
			return linphone_core_is_echo_canceller_calibration_required(cPtr) != 0
	}

	/// Returns whether or not friend lists subscription are enabled. 
	/// - Returns: whether or not the feature is enabled 
	public var isFriendListSubscriptionEnabled: Bool
	{
			return linphone_core_is_friend_list_subscription_enabled(cPtr) != 0
	}

	/// Indicates whether the local participant is part of a conference. 
	/// - Warning: That function automatically fails in the case of conferences using a
	/// conferencet server (focus). If you use such a conference, you should use {@link
	/// Conference#removeParticipant} instead. 
	/// 
	/// - Returns:  if the local participant is in a conference, true otherwise. 
	public var isInConference: Bool
	{
			return linphone_core_is_in_conference(cPtr) != 0
	}

	/// Tells whether there is an incoming invite pending. 
	/// - Returns: A boolean telling whether an incoming invite is pending or not. 
	public var isIncomingInvitePending: Bool
	{
			return linphone_core_is_incoming_invite_pending(cPtr) != 0
	}

	/// Check if the configured media encryption is mandatory or not. 
	/// - Returns:  if media encryption is mandatory; true otherwise. 
	public var isMediaEncryptionMandatory: Bool
	{
			return linphone_core_is_media_encryption_mandatory(cPtr) != 0
	}

	/// return network state either as positioned by the application or by linphone
	/// itself. 
	public var isNetworkReachable: Bool
	{
			return linphone_core_is_network_reachable(cPtr) != 0
	}

	/// Returns whether or not sender name is hidden in forward message. 
	/// - Returns: whether or not the feature 
	public var isSenderNameHiddenInForwardMessage: Bool
	{
			return linphone_core_is_sender_name_hidden_in_forward_message(cPtr) != 0
	}

	/// Is signaling keep alive enabled. 
	/// - Returns: A boolean value telling whether signaling keep alive is enabled 
	public var keepAliveEnabled: Bool
	{
		get
		{
			return linphone_core_keep_alive_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_keep_alive(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the latest outgoing call log. 
	/// - Returns: {LinphoneCallLog} 
	public var lastOutgoingCallLog: CallLog?
	{
			let cPointer = linphone_core_get_last_outgoing_call_log(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return CallLog.getSwiftObject(cObject:cPointer!)
	}

	/// Tells wether LIME X3DH is enabled or not. 
	/// - Returns: The current lime state 
	public var limeX3DhEnabled: Bool
	{
		get
		{
			return linphone_core_lime_x3dh_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_lime_x3dh(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the x3dh server url. 
	public var limeX3DhServerUrl: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_lime_x3dh_server_url(cPtr))
		}
		set
		{
			linphone_core_set_lime_x3dh_server_url(cPtr, newValue)
		}
	}

	/// Get the list of linphone specs string values representing what functionalities
	/// the linphone client supports. 
	/// - Returns: A list of char * objects. char *  a list of supported specs. The
	/// list must be freed with bctbx_list_free() after usage 
	public var linphoneSpecsList: [String]
	{
		get
		{
			var swiftList = [String]()
			var cList = linphone_core_get_linphone_specs_list(cPtr)
			while (cList != nil) {
				swiftList.append(String(cString: unsafeBitCast(cList!.pointee.data, to: UnsafePointer<CChar>.self)))
				cList = UnsafePointer<bctbx_list_t>(cList!.pointee.next)
			}
			return swiftList
		}
		set
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				let sData:NSString = data as NSString
				cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
			}
			linphone_core_set_linphone_specs_list(cPtr, cList)
		}
	}

	/// Gets the url of the server where to upload the collected log files. 
	/// - Returns: The url of the server where to upload the collected log files. 
	public var logCollectionUploadServerUrl: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_log_collection_upload_server_url(cPtr))
		}
		set
		{
			linphone_core_set_log_collection_upload_server_url(cPtr, newValue)
		}
	}

	/// Get the maximum number of simultaneous calls Linphone core can manage at a
	/// time. 
	/// All new call above this limit are declined with a busy answer 
	/// 
	/// - Returns: max number of simultaneous calls 
	public var maxCalls: Int
	{
		get
		{
			return Int(linphone_core_get_max_calls(cPtr))
		}
		set
		{
			linphone_core_set_max_calls(cPtr, CInt(newValue))
		}
	}

	/// Gets the size under which incoming files in chat messages will be downloaded
	/// automatically. 
	/// - Returns: The size in bytes, -1 if autodownload feature is disabled, 0 to
	/// download them all no matter the size 
	public var maxSizeForAutoDownloadIncomingFiles: Int
	{
		get
		{
			return Int(linphone_core_get_max_size_for_auto_download_incoming_files(cPtr))
		}
		set
		{
			linphone_core_set_max_size_for_auto_download_incoming_files(cPtr, CInt(newValue))
		}
	}

	/// Gets the name of the currently assigned sound device for media. 
	/// - Returns: The name of the currently assigned sound device for capture 
	public var mediaDevice: String
	{
			return charArrayToString(charPointer: linphone_core_get_media_device(cPtr))
	}

	public func setMediadevice(newValue: String) throws
	{
		let exception_result = linphone_core_set_media_device(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the media encryption policy being used for RTP packets. 
	/// - Returns: The media encryption policy being used. 
	public var mediaEncryption: MediaEncryption
	{
			return MediaEncryption(rawValue: Int(linphone_core_get_media_encryption(cPtr).rawValue))!
	}

	public func setMediaencryption(newValue: MediaEncryption) throws
	{
		let exception_result = linphone_core_set_media_encryption(cPtr, LinphoneMediaEncryption(rawValue: CUnsignedInt(newValue.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Define whether the configured media encryption is mandatory, if it is and the
	/// negotation cannot result in the desired media encryption then the call will
	/// fail. 
	/// If not an INVITE will be resent with encryption disabled. 
	/// 
	/// - Parameter m:  to set it mandatory; true otherwise. 
	/// 
	public var mediaEncryptionMandatory: Bool?
	{
		willSet
		{
			linphone_core_set_media_encryption_mandatory(cPtr, newValue==true ? 1:0)
		}
	}

	/// This method is called by the application to notify the linphone core library
	/// when the media (RTP) network is reachable. 
	/// This is for advanced usage, when SIP and RTP layers are required to use
	/// different interfaces. Most applications just need {@link
	/// Core#setNetworkReachable}. 
	public var mediaNetworkReachable: Bool?
	{
		willSet
		{
			linphone_core_set_media_network_reachable(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether the microphone is enabled. 
	/// - Returns:  if the microphone is enabled, true if disabled. 
	public var micEnabled: Bool
	{
		get
		{
			return linphone_core_mic_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_mic(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get microphone gain in db. 
	/// - Returns: The current microphone gain 
	public var micGainDb: Float
	{
		get
		{
			return linphone_core_get_mic_gain_db(cPtr)
		}
		set
		{
			linphone_core_set_mic_gain_db(cPtr, newValue)
		}
	}

	/// Get the number of missed calls. 
	/// Once checked, this counter can be reset with {@link
	/// Core#resetMissedCallsCount}. 
	/// 
	/// - Returns: The number of missed calls. 
	public var missedCallsCount: Int
	{
			return Int(linphone_core_get_missed_calls_count(cPtr))
	}

	/// Returns the maximum transmission unit size in bytes. 
	public var mtu: Int
	{
		get
		{
			return Int(linphone_core_get_mtu(cPtr))
		}
		set
		{
			linphone_core_set_mtu(cPtr, CInt(newValue))
		}
	}

	/// Get the public IP address of NAT being used. 
	/// - Returns: The public IP address of NAT being used. 
	public var natAddress: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_nat_address(cPtr))
		}
		set
		{
			linphone_core_set_nat_address(cPtr, newValue)
		}
	}

	/// Get The policy that is used to pass through NATs/firewalls. 
	/// It may be overridden by a NAT policy for a specific proxy config. 
	/// 
	/// - Returns: `NatPolicy` object in use.
	/// 
	/// - See also: {@link ProxyConfig#getNatPolicy} 
	public var natPolicy: NatPolicy?
	{
		get
		{
			let cPointer = linphone_core_get_nat_policy(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return NatPolicy.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_core_set_nat_policy(cPtr, newValue?.cPtr)
		}
	}

	/// Get the native window handle of the video preview window. 
	/// - Returns: The native window handle of the video preview window 
	public var nativePreviewWindowId: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_core_get_native_preview_window_id(cPtr)
		}
		set
		{
			linphone_core_set_native_preview_window_id(cPtr, newValue)
		}
	}

	/// Get the native window handle of the video window. 
	/// - Returns: The native window handle of the video window 
	public var nativeVideoWindowId: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_core_get_native_video_window_id(cPtr)
		}
		set
		{
			linphone_core_set_native_video_window_id(cPtr, newValue)
		}
	}

	/// This method is called by the application to notify the linphone core library
	/// when network is reachable. 
	/// Calling this method with true trigger linphone to initiate a registration
	/// process for all proxies. Calling this method disables the automatic network
	/// detection mode. It means you must call this method after each network state
	/// changes. 
	public var networkReachable: Bool?
	{
		willSet
		{
			linphone_core_set_network_reachable(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the value of the no-rtp timeout. 
	/// When no RTP or RTCP packets have been received for a while `Core` will consider
	/// the call is broken (remote end crashed or disconnected from the network), and
	/// thus will terminate the call. The no-rtp timeout is the duration above which
	/// the call is considered broken. 
	/// 
	/// - Returns: The value of the no-rtp timeout in seconds 
	public var nortpTimeout: Int
	{
		get
		{
			return Int(linphone_core_get_nortp_timeout(cPtr))
		}
		set
		{
			linphone_core_set_nortp_timeout(cPtr, CInt(newValue))
		}
	}

	/// Get the wav file that is played when putting somebody on hold, or when files
	/// are used instead of soundcards (see {@link Core#setUseFiles}). 
	/// The file is a 16 bit linear wav file. 
	/// 
	/// - Returns: The path to the file that is played when putting somebody on hold. 
	public var playFile: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_play_file(cPtr))
		}
		set
		{
			linphone_core_set_play_file(cPtr, newValue)
		}
	}

	/// Gets the name of the currently assigned sound device for playback. 
	/// - Returns: The name of the currently assigned sound device for playback 
	public var playbackDevice: String
	{
			return charArrayToString(charPointer: linphone_core_get_playback_device(cPtr))
	}

	public func setPlaybackdevice(newValue: String) throws
	{
		let exception_result = linphone_core_set_playback_device(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get playback gain in db before entering sound card. 
	/// - Returns: The current playback gain 
	public var playbackGainDb: Float
	{
		get
		{
			return linphone_core_get_playback_gain_db(cPtr)
		}
		set
		{
			linphone_core_set_playback_gain_db(cPtr, newValue)
		}
	}

	/// Returns the preferred video framerate, previously set by {@link
	/// Core#setPreferredFramerate}. 
	/// - Returns: frame rate in number of frames per seconds. 
	public var preferredFramerate: Float
	{
		get
		{
			return linphone_core_get_preferred_framerate(cPtr)
		}
		set
		{
			linphone_core_set_preferred_framerate(cPtr, newValue)
		}
	}

	/// Get the preferred video definition for the stream that is captured and sent to
	/// the remote party. 
	/// - Returns: The preferred `VideoDefinition` 
	public var preferredVideoDefinition: VideoDefinition?
	{
		get
		{
			let cPointer = linphone_core_get_preferred_video_definition(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return VideoDefinition.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_core_set_preferred_video_definition(cPtr, newValue?.cPtr)
		}
	}

	/// Sets the preferred video size by its name. 
	/// This is identical to linphone_core_set_preferred_video_size except that it
	/// takes the name of the video resolution as input. Video resolution names are:
	/// qcif, svga, cif, vga, 4cif, svga ...
	/// 
	/// - deprecated: Use {@link Factory#createVideoDefinitionFromName} and {@link
	/// Core#setPreferredVideoDefinition} instead 
	public var preferredVideoSizeByName: String = ""
	{
		willSet
		{
			linphone_core_set_preferred_video_size_by_name(cPtr, newValue)
		}
	}

	/// Get my presence model. 
	/// - Returns: A `PresenceModel` object, or nil if no presence model has been set. 
	public var presenceModel: PresenceModel?
	{
		get
		{
			let cPointer = linphone_core_get_presence_model(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return PresenceModel.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_core_set_presence_model(cPtr, newValue?.cPtr)
		}
	}

	/// Get the definition of the captured video. 
	/// - Returns: The captured `VideoDefinition` if it was previously set by {@link
	/// Core#setPreviewVideoDefinition}, otherwise a 0x0 LinphoneVideoDefinition. 
	/// 
	/// - See also: {@link Core#setPreviewVideoDefinition} 
	public var previewVideoDefinition: VideoDefinition?
	{
		get
		{
			let cPointer = linphone_core_get_preview_video_definition(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return VideoDefinition.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_core_set_preview_video_definition(cPtr, newValue?.cPtr)
		}
	}

	/// Sets the preview video size by its name. 
	/// See linphone_core_set_preview_video_size for more information about this
	/// feature.
	/// 
	/// Video resolution names are: qcif, svga, cif, vga, 4cif, svga ...
	/// 
	/// - deprecated: Use {@link Factory#createVideoDefinitionFromName} and {@link
	/// Core#setPreviewVideoDefinition} instead 
	public var previewVideoSizeByName: String = ""
	{
		willSet
		{
			linphone_core_set_preview_video_size_by_name(cPtr, newValue)
		}
	}

	/// Returns the default identity when no proxy configuration is used. 
	public var primaryContact: String
	{
			return charArrayToString(charPointer: linphone_core_get_primary_contact(cPtr))
	}

	public func setPrimarycontact(newValue: String) throws
	{
		let exception_result = linphone_core_set_primary_contact(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Same as {@link Core#getPrimaryContact} but the result is a `Address` object
	/// instead of const char *. 
	/// - deprecated: Use {@link Core#createPrimaryContactParsed} instead. Deprecated
	/// since 2018-10-22. 
	public var primaryContactParsed: Address?
	{
			let cPointer = linphone_core_get_primary_contact_parsed(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Get provisioning URI. 
	/// - Returns: the provisioning URI. 
	public var provisioningUri: String
	{
			return charArrayToString(charPointer: linphone_core_get_provisioning_uri(cPtr))
	}

	public func setProvisioninguri(newValue: String) throws
	{
		let exception_result = linphone_core_set_provisioning_uri(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns an unmodifiable list of entered proxy configurations. 
	/// - Returns: A list of `ProxyConfig` objects. LinphoneProxyConfig  
	public var proxyConfigList: [ProxyConfig]
	{
			var swiftList = [ProxyConfig]()
			var cList = linphone_core_get_proxy_config_list(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(ProxyConfig.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Tells whether QRCode is enabled in the preview. 
	/// - Returns: A boolean value telling whether QRCode is enabled in the preview. 
	public var qrcodeVideoPreviewEnabled: Bool
	{
		get
		{
			return linphone_core_qrcode_video_preview_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_qrcode_video_preview(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets if realtime text is enabled or not. 
	/// - Returns: true if realtime text is enabled, false otherwise 
	public var realtimeTextEnabled: Bool
	{
			return linphone_core_realtime_text_enabled(cPtr) != 0
	}

	/// Get the wav file where incoming stream is recorded, when files are used instead
	/// of soundcards (see {@link Core#setUseFiles}). 
	/// This feature is different from call recording ({@link
	/// CallParams#setRecordFile}) The file is a 16 bit linear wav file. 
	/// 
	/// - Returns: The path to the file where incoming stream is recorded. 
	public var recordFile: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_record_file(cPtr))
		}
		set
		{
			linphone_core_set_record_file(cPtr, newValue)
		}
	}

	/// Get the ring back tone played to far end during incoming calls. 
	public var remoteRingbackTone: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_remote_ringback_tone(cPtr))
		}
		set
		{
			linphone_core_set_remote_ringback_tone(cPtr, newValue)
		}
	}

	/// Tells whether NACK context is enabled or not. 
	/// - Returns: A boolean value telling whether NACK context is enabled or not 
	public var retransmissionOnNackEnabled: Bool
	{
		get
		{
			return linphone_core_retransmission_on_nack_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_retransmission_on_nack(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns the path to the wav file used for ringing. 
	/// - Returns: The path to the wav file used for ringing 
	public var ring: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_ring(cPtr))
		}
		set
		{
			linphone_core_set_ring(cPtr, newValue)
		}
	}

	/// Tells whether the ring play is enabled during an incoming early media call. 
	public var ringDuringIncomingEarlyMedia: Bool
	{
		get
		{
			return linphone_core_get_ring_during_incoming_early_media(cPtr) != 0
		}
		set
		{
			linphone_core_set_ring_during_incoming_early_media(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns the path to the wav file used for ringing back. 
	/// - Returns: The path to the wav file used for ringing back 
	public var ringback: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_ringback(cPtr))
		}
		set
		{
			linphone_core_set_ringback(cPtr, newValue)
		}
	}

	/// Gets the name of the currently assigned sound device for ringing. 
	/// - Returns: The name of the currently assigned sound device for ringing 
	public var ringerDevice: String
	{
			return charArrayToString(charPointer: linphone_core_get_ringer_device(cPtr))
	}

	public func setRingerdevice(newValue: String) throws
	{
		let exception_result = linphone_core_set_ringer_device(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the path to a file or folder containing the trusted root CAs (PEM format) 
	/// - Returns: The path to a file or folder containing the trusted root CAs 
	public var rootCa: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_root_ca(cPtr))
		}
		set
		{
			linphone_core_set_root_ca(cPtr, newValue)
		}
	}

	/// Sets the trusted root CAs (PEM format) 
	/// - Parameter data: The trusted root CAs as a string 
	/// 
	public var rootCaData: String = ""
	{
		willSet
		{
			linphone_core_set_root_ca_data(cPtr, newValue)
		}
	}

	/// Returns whether RTP bundle mode (also known as Media Multiplexing) is enabled. 
	/// See https://tools.ietf.org/html/draft-ietf-mmusic-sdp-bundle-negotiation-54 for
	/// more information. 
	/// 
	/// - Returns: a boolean indicating the enablement of rtp bundle mode. 
	public var rtpBundleEnabled: Bool
	{
		get
		{
			return linphone_core_rtp_bundle_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_rtp_bundle(cPtr, newValue==true ? 1:0)
		}
	}

	/// Media offer control param for SIP INVITE. 
	/// - Returns: true if INVITE has to be sent whitout SDP. 
	public var sdp200AckEnabled: Bool
	{
		get
		{
			return linphone_core_sdp_200_ack_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_sdp_200_ack(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether video self view during call is enabled or not. 
	/// - Returns: A boolean value telling whether self view is enabled 
	/// 
	/// - See also: {@link Core#enableSelfView} for details. 
	public var selfViewEnabled: Bool
	{
		get
		{
			return linphone_core_self_view_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_self_view(cPtr, newValue==true ? 1:0)
		}
	}

	/// Enable whether or not to hide sender name in forward message. 
	/// - Parameter enable: whether or not to enable the feature 
	/// 
	public var senderNameHiddenInForwardMessageEnabled: Bool?
	{
		willSet
		{
			linphone_core_enable_sender_name_hidden_in_forward_message(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check if the Session Timers feature is enabled. 
	public var sessionExpiresEnabled: Bool
	{
		get
		{
			return linphone_core_get_session_expires_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_set_session_expires_enabled(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns the session expires min value, 90 by default. 
	public var sessionExpiresMinValue: Int
	{
		get
		{
			return Int(linphone_core_get_session_expires_min_value(cPtr))
		}
		set
		{
			linphone_core_set_session_expires_min_value(cPtr, CInt(newValue))
		}
	}

	/// Returns the session expires refresher value. 
	public var sessionExpiresRefresherValue: SessionExpiresRefresher
	{
		get
		{
			return SessionExpiresRefresher(rawValue: Int(linphone_core_get_session_expires_refresher_value(cPtr).rawValue))!
		}
		set
		{
			linphone_core_set_session_expires_refresher_value(cPtr, LinphoneSessionExpiresRefresher(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Returns the session expires value. 
	public var sessionExpiresValue: Int
	{
		get
		{
			return Int(linphone_core_get_session_expires_value(cPtr))
		}
		set
		{
			linphone_core_set_session_expires_value(cPtr, CInt(newValue))
		}
	}

	/// Get the DSCP field for SIP signaling channel. 
	/// The DSCP defines the quality of service in IP packets. 
	/// 
	/// - Returns: The current DSCP value 
	public var sipDscp: Int
	{
		get
		{
			return Int(linphone_core_get_sip_dscp(cPtr))
		}
		set
		{
			linphone_core_set_sip_dscp(cPtr, CInt(newValue))
		}
	}

	/// This method is called by the application to notify the linphone core library
	/// when the SIP network is reachable. 
	/// This is for advanced usage, when SIP and RTP layers are required to use
	/// different interfaces. Most applications just need {@link
	/// Core#setNetworkReachable}. 
	public var sipNetworkReachable: Bool?
	{
		willSet
		{
			linphone_core_set_sip_network_reachable(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the SIP transport timeout. 
	/// - Returns: The SIP transport timeout in milliseconds. 
	public var sipTransportTimeout: Int
	{
		get
		{
			return Int(linphone_core_get_sip_transport_timeout(cPtr))
		}
		set
		{
			linphone_core_set_sip_transport_timeout(cPtr, CInt(newValue))
		}
	}

	/// Gets the list of the available sound devices. 
	/// - Returns: A list of char * objects. char *  An unmodifiable array of strings
	/// contanining the names of the available sound devices that is nil terminated 
	public var soundDevicesList: [String]
	{
			var swiftList = [String]()
			var cList = linphone_core_get_sound_devices_list(cPtr)
			while (cList != nil) {
				swiftList.append(String(cString: unsafeBitCast(cList!.pointee.data, to: UnsafePointer<CChar>.self)))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList!.pointee.next)
			}
			return swiftList
	}

	/// Get the path to the image file streamed when "Static picture" is set as the
	/// video device. 
	/// - Returns: The path to the image file streamed when "Static picture" is set as
	/// the video device. 
	public var staticPicture: String
	{
			return charArrayToString(charPointer: linphone_core_get_static_picture(cPtr))
	}

	public func setStaticpicture(newValue: String) throws
	{
		let exception_result = linphone_core_set_static_picture(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the frame rate for static picture. 
	/// - Returns: The frame rate used for static picture. 
	public var staticPictureFps: Float
	{
			return linphone_core_get_static_picture_fps(cPtr)
	}

	public func setStaticpicturefps(newValue: Float) throws
	{
		let exception_result = linphone_core_set_static_picture_fps(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the STUN server address being used. 
	/// - Returns: The STUN server address being used. 
	public var stunServer: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_stun_server(cPtr))
		}
		set
		{
			linphone_core_set_stun_server(cPtr, newValue)
		}
	}

	/// Returns a null terminated table of strings containing the file format extension
	/// supported for call recording. 
	/// - Returns: A list of char * objects. char *  the supported formats, typically
	/// 'wav' and 'mkv' 
	public var supportedFileFormatsList: [String]
	{
			var swiftList = [String]()
			var cList = linphone_core_get_supported_file_formats_list(cPtr)
			while (cList != nil) {
				swiftList.append(String(cString: unsafeBitCast(cList!.pointee.data, to: UnsafePointer<CChar>.self)))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList!.pointee.next)
			}
			return swiftList
	}

	/// Set the supported tags. 
	public var supportedTag: String = ""
	{
		willSet
		{
			linphone_core_set_supported_tag(cPtr, newValue)
		}
	}

	/// Return the list of the available text payload types. 
	/// - Returns: A list of `PayloadType` objects. LinphonePayloadType  A freshly
	/// allocated list of the available payload types. The list must be destroyed with
	/// bctbx_list_free() after usage. The elements of the list haven't to be unref. 
	public var textPayloadTypes: [PayloadType]
	{
		get
		{
			var swiftList = [PayloadType]()
			var cList = linphone_core_get_text_payload_types(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(PayloadType.getSwiftObject(cObject: data))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
		}
		set
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				cList = bctbx_list_append(cList, UnsafeMutableRawPointer(data.cPtr))
			}
			linphone_core_set_text_payload_types(cPtr, cList)
		}
	}

	/// Gets the UDP port used for text streaming. 
	/// - Returns: The UDP port used for text streaming 
	public var textPort: Int
	{
		get
		{
			return Int(linphone_core_get_text_port(cPtr))
		}
		set
		{
			linphone_core_set_text_port(cPtr, CInt(newValue))
		}
	}

	/// Get the text port range from which is randomly chosen the UDP port used for
	/// text streaming. 
	/// - Returns: a `Range` object 
	public var textPortsRange: Range?
	{
			let cPointer = linphone_core_get_text_ports_range(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Range.getSwiftObject(cObject:cPointer!)
	}

	/// Gets the TLS certificate. 
	/// - Returns: the TLS certificate or nil if not set yet 
	public var tlsCert: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_tls_cert(cPtr))
		}
		set
		{
			linphone_core_set_tls_cert(cPtr, newValue)
		}
	}

	/// Gets the path to the TLS certificate file. 
	/// - Returns: the TLS certificate path or nil if not set yet 
	public var tlsCertPath: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_tls_cert_path(cPtr))
		}
		set
		{
			linphone_core_set_tls_cert_path(cPtr, newValue)
		}
	}

	/// Gets the TLS key. 
	/// - Returns: the TLS key or nil if not set yet 
	public var tlsKey: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_tls_key(cPtr))
		}
		set
		{
			linphone_core_set_tls_key(cPtr, newValue)
		}
	}

	/// Gets the path to the TLS key file. 
	/// - Returns: the TLS key path or nil if not set yet 
	public var tlsKeyPath: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_tls_key_path(cPtr))
		}
		set
		{
			linphone_core_set_tls_key_path(cPtr, newValue)
		}
	}

	/// Retrieves the port configuration used for each transport (udp, tcp, tls). 
	/// A zero value port for a given transport means the transport is not used. A
	/// value of LC_SIP_TRANSPORT_RANDOM (-1) means the port is to be chosen randomly
	/// by the system. 
	/// 
	/// - Returns: A `Transports` structure with the configured ports 
	public var transports: Transports?
	{
			let cPointer = linphone_core_get_transports(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Transports.getSwiftObject(cObject:cPointer!)
	}

	public func setTransports(newValue: Transports) throws
	{
		let exception_result = linphone_core_set_transports(cPtr, newValue.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Retrieves the real port number assigned for each sip transport (udp, tcp, tls). 
	/// A zero value means that the transport is not activated. If
	/// LC_SIP_TRANSPORT_RANDOM was passed to linphone_core_set_sip_transports, the
	/// random port choosed by the system is returned. 
	/// 
	/// - Returns: A `Transports` structure with the ports being used 
	public var transportsUsed: Transports?
	{
			let cPointer = linphone_core_get_transports_used(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Transports.getSwiftObject(cObject:cPointer!)
	}

	/// get tunnel instance if available 
	/// - Returns: `Tunnel` or nil if not available 
	public var tunnel: Tunnel?
	{
			let cPointer = linphone_core_get_tunnel(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Tunnel.getSwiftObject(cObject:cPointer!)
	}

	/// Return the global unread chat message count. 
	/// - Returns: The global unread chat message count. 
	public var unreadChatMessageCount: Int
	{
			return Int(linphone_core_get_unread_chat_message_count(cPtr))
	}

	/// Return the unread chat message count for all active local address. 
	/// (Primary contact + proxy configs.) 
	/// 
	/// - Returns: The unread chat message count. 
	public var unreadChatMessageCountFromActiveLocals: Int
	{
			return Int(linphone_core_get_unread_chat_message_count_from_active_locals(cPtr))
	}

	/// Retrieve the maximum available upload bandwidth. 
	/// This value was set by {@link Core#setUploadBandwidth}. 
	public var uploadBandwidth: Int
	{
		get
		{
			return Int(linphone_core_get_upload_bandwidth(cPtr))
		}
		set
		{
			linphone_core_set_upload_bandwidth(cPtr, CInt(newValue))
		}
	}

	/// Set audio packetization time linphone will send (in absence of requirement from
	/// peer) A value of 0 stands for the current codec default packetization time. 
	public var uploadPtime: Int
	{
		get
		{
			return Int(linphone_core_get_upload_ptime(cPtr))
		}
		set
		{
			linphone_core_set_upload_ptime(cPtr, CInt(newValue))
		}
	}

	/// Return the external ip address of router. 
	/// In some cases the uPnP can have an external ip address but not a usable uPnP
	/// (state different of Ok).
	/// 
	/// - Returns: a null terminated string containing the external ip address. If the
	/// the external ip address is not available return null. 
	public var upnpExternalIpaddress: String
	{
			return charArrayToString(charPointer: linphone_core_get_upnp_external_ipaddress(cPtr))
	}

	/// Return the internal state of uPnP. 
	/// - Returns: an LinphoneUpnpState. 
	public var upnpState: UpnpState
	{
			return UpnpState(rawValue: Int(linphone_core_get_upnp_state(cPtr).rawValue))!
	}

	/// Gets whether linphone is currently streaming audio from and to files, rather
	/// than using the soundcard. 
	/// - Returns: A boolean value representing whether linphone is streaming audio
	/// from and to files or not. 
	public var useFiles: Bool
	{
		get
		{
			return linphone_core_get_use_files(cPtr) != 0
		}
		set
		{
			linphone_core_set_use_files(cPtr, newValue==true ? 1:0)
		}
	}

	/// Indicates whether SIP INFO is used to send digits. 
	/// - Returns: A boolean value telling whether SIP INFO is used to send digits 
	public var useInfoForDtmf: Bool
	{
		get
		{
			return linphone_core_get_use_info_for_dtmf(cPtr) != 0
		}
		set
		{
			linphone_core_set_use_info_for_dtmf(cPtr, newValue==true ? 1:0)
		}
	}

	/// Indicates whether RFC2833 is used to send digits. 
	/// - Returns: A boolean value telling whether RFC2833 is used to send digits 
	public var useRfc2833ForDtmf: Bool
	{
		get
		{
			return linphone_core_get_use_rfc2833_for_dtmf(cPtr) != 0
		}
		set
		{
			linphone_core_set_use_rfc2833_for_dtmf(cPtr, newValue==true ? 1:0)
		}
	}

	/// - Returns: liblinphone's user agent as a string. 
	public var userAgent: String
	{
			return charArrayToString(charPointer: linphone_core_get_user_agent(cPtr))
	}

	/// Get the path to the directory storing the user's certificates. 
	/// - Returns: The path to the directory storing the user's certificates. 
	public var userCertificatesPath: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_user_certificates_path(cPtr))
		}
		set
		{
			linphone_core_set_user_certificates_path(cPtr, newValue)
		}
	}

	/// Retrieves the user pointer that was given to linphone_core_new 
	/// - Returns: The user data associated with the `Core` object 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_core_get_user_data(cPtr)
		}
		set
		{
			linphone_core_set_user_data(cPtr, newValue)
		}
	}

	/// Get the default policy for video. 
	/// See {@link Core#setVideoActivationPolicy} for more details. 
	/// 
	/// - Returns: The video policy being used 
	public var videoActivationPolicy: VideoActivationPolicy?
	{
		get
		{
			let cPointer = linphone_core_get_video_activation_policy(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return VideoActivationPolicy.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_core_set_video_activation_policy(cPtr, newValue?.cPtr)
		}
	}

	/// Tells whether the video adaptive jitter compensation is enabled. 
	/// - Returns:  if the video adaptive jitter compensation is enabled, true
	/// otherwise. 
	public var videoAdaptiveJittcompEnabled: Bool
	{
		get
		{
			return linphone_core_video_adaptive_jittcomp_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_video_adaptive_jittcomp(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether video capture is enabled. 
	/// - Returns:  if video capture is enabled, true if disabled. 
	public var videoCaptureEnabled: Bool
	{
		get
		{
			return linphone_core_video_capture_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_video_capture(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns the name of the currently active video device. 
	/// - Returns: The name of the currently active video device 
	public var videoDevice: String
	{
			return charArrayToString(charPointer: linphone_core_get_video_device(cPtr))
	}

	public func setVideodevice(newValue: String) throws
	{
		let exception_result = linphone_core_set_video_device(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the list of the available video capture devices. 
	/// - Returns: A list of char * objects. char *  An unmodifiable array of strings
	/// contanining the names of the available video capture devices that is nil
	/// terminated 
	public var videoDevicesList: [String]
	{
			var swiftList = [String]()
			var cList = linphone_core_get_video_devices_list(cPtr)
			while (cList != nil) {
				swiftList.append(String(cString: unsafeBitCast(cList!.pointee.data, to: UnsafePointer<CChar>.self)))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList!.pointee.next)
			}
			return swiftList
	}

	/// Tells whether video display is enabled. 
	/// - Returns:  if video display is enabled, true if disabled. 
	public var videoDisplayEnabled: Bool
	{
		get
		{
			return linphone_core_video_display_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_video_display(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the name of the mediastreamer2 filter used for rendering video. 
	/// - Returns: The currently selected video display filter 
	public var videoDisplayFilter: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_video_display_filter(cPtr))
		}
		set
		{
			linphone_core_set_video_display_filter(cPtr, newValue)
		}
	}

	/// Get the DSCP field for outgoing video streams. 
	/// The DSCP defines the quality of service in IP packets. 
	/// 
	/// - Returns: The current DSCP value 
	public var videoDscp: Int
	{
		get
		{
			return Int(linphone_core_get_video_dscp(cPtr))
		}
		set
		{
			linphone_core_set_video_dscp(cPtr, CInt(newValue))
		}
	}

	/// Returns true if either capture or display is enabled, true otherwise. 
	/// same as ( linphone_core_video_capture_enabled |
	/// linphone_core_video_display_enabled ) 
	public var videoEnabled: Bool
	{
			return linphone_core_video_enabled(cPtr) != 0
	}

	/// Returns the nominal video jitter buffer size in milliseconds. 
	/// - Returns: The nominal video jitter buffer size in milliseconds 
	public var videoJittcomp: Int
	{
		get
		{
			return Int(linphone_core_get_video_jittcomp(cPtr))
		}
		set
		{
			linphone_core_set_video_jittcomp(cPtr, CInt(newValue))
		}
	}

	/// Use to get multicast address to be used for video stream. 
	/// - Returns: an ipv4/6 multicast address, or default value 
	public var videoMulticastAddr: String
	{
			return charArrayToString(charPointer: linphone_core_get_video_multicast_addr(cPtr))
	}

	public func setVideomulticastaddr(newValue: String) throws
	{
		let exception_result = linphone_core_set_video_multicast_addr(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Use to get multicast state of video stream. 
	/// - Returns: true if subsequent calls will propose multicast ip set by
	/// linphone_core_set_video_multicast_addr 
	public var videoMulticastEnabled: Bool
	{
		get
		{
			return linphone_core_video_multicast_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_video_multicast(cPtr, newValue==true ? 1:0)
		}
	}

	/// Use to get multicast ttl to be used for video stream. 
	/// - Returns: a time to leave value 
	public var videoMulticastTtl: Int
	{
			return Int(linphone_core_get_video_multicast_ttl(cPtr))
	}

	public func setVideomulticastttl(newValue: Int) throws
	{
		let exception_result = linphone_core_set_video_multicast_ttl(cPtr, CInt(newValue))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Return the list of the available video payload types. 
	/// - Returns: A list of `PayloadType` objects. LinphonePayloadType  A freshly
	/// allocated list of the available payload types. The list must be destroyed with
	/// bctbx_list_free() after usage. The elements of the list haven't to be unref. 
	public var videoPayloadTypes: [PayloadType]
	{
		get
		{
			var swiftList = [PayloadType]()
			var cList = linphone_core_get_video_payload_types(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(PayloadType.getSwiftObject(cObject: data))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
		}
		set
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				cList = bctbx_list_append(cList, UnsafeMutableRawPointer(data.cPtr))
			}
			linphone_core_set_video_payload_types(cPtr, cList)
		}
	}

	/// Gets the UDP port used for video streaming. 
	/// - Returns: The UDP port used for video streaming 
	public var videoPort: Int
	{
		get
		{
			return Int(linphone_core_get_video_port(cPtr))
		}
		set
		{
			linphone_core_set_video_port(cPtr, CInt(newValue))
		}
	}

	/// Get the video port range from which is randomly chosen the UDP port used for
	/// video streaming. 
	/// - Returns: a `Range` object 
	public var videoPortsRange: Range?
	{
			let cPointer = linphone_core_get_video_ports_range(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Range.getSwiftObject(cObject:cPointer!)
	}

	/// Get the video preset used for video calls. 
	/// - Returns: The name of the video preset used for video calls (can be nil if the
	/// default video preset is used). 
	public var videoPreset: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_video_preset(cPtr))
		}
		set
		{
			linphone_core_set_video_preset(cPtr, newValue)
		}
	}

	/// Tells whether video preview is enabled. 
	/// - Returns: A boolean value telling whether video preview is enabled 
	public var videoPreviewEnabled: Bool
	{
		get
		{
			return linphone_core_video_preview_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_video_preview(cPtr, newValue==true ? 1:0)
		}
	}

	/// Enable or disable video source reuse when switching from preview to actual
	/// video call. 
	/// This source reuse is useful when you always display the preview, even before
	/// calls are initiated. By keeping the video source for the transition to a real
	/// video call, you will smooth out the source close/reopen cycle.
	/// 
	/// This function does not have any effect durfing calls. It just indicates the
	/// `Core` to initiate future calls with video source reuse or not. Also, at the
	/// end of a video call, the source will be closed whatsoever for now. 
	/// 
	/// - Parameter enable:  to enable video source reuse. true to disable it for
	/// subsequent calls. 
	/// 
	public var videoSourceReuseEnabled: Bool?
	{
		willSet
		{
			linphone_core_enable_video_source_reuse(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether Wifi only mode is enabled or not. 
	/// - Returns: A boolean value telling whether Wifi only mode is enabled or not 
	public var wifiOnlyEnabled: Bool
	{
		get
		{
			return linphone_core_wifi_only_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_wifi_only(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the path to the file storing the zrtp secrets cache. 
	/// - Returns: The path to the file storing the zrtp secrets cache. 
	public var zrtpSecretsFile: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_core_get_zrtp_secrets_file(cPtr))
		}
		set
		{
			linphone_core_set_zrtp_secrets_file(cPtr, newValue)
		}
	}
	///	Special function to indicate if the audio session is activated. 
	/// Must be called when ProviderDelegate of the callkit notifies that the audio
	/// session is activated or deactivated. 
	public func activateAudioSession(actived:Bool) 
	{
		linphone_core_activate_audio_session(cPtr, actived==true ? 1:0)
	}
	///	Add all current calls into the conference. 
	/// If no conference is running a new internal conference context is created and
	/// all current calls are added to it. 
	/// 
	/// - Returns: 0 if succeeded. Negative number if failed 
	public func addAllToConference() throws 
	{
		let exception_result = linphone_core_add_all_to_conference(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addAllToConference returned value \(exception_result)")
		}
	}
	///	Adds authentication information to the `Core`. 
	/// That piece of information will be used during all SIP transactions that require
	/// authentication. 
	/// 
	/// - Parameter info: The `AuthInfo` to add. 
	/// 
	public func addAuthInfo(info:AuthInfo) 
	{
		linphone_core_add_auth_info(cPtr, info.cPtr)
	}
	///	Add a friend to the current buddy list, if subscription attribute  is set, a
	///	SIP SUBSCRIBE message is sent. 
	/// - Parameter fr: `Friend` to add 
	/// 
	/// 
	/// - deprecated: use {@link FriendList#addFriend} instead. 
	public func addFriend(fr:Friend) 
	{
		linphone_core_add_friend(cPtr, fr.cPtr)
	}
	///	Add a friend list. 
	/// - Parameter list: `FriendList` object 
	/// 
	public func addFriendList(list:FriendList) 
	{
		linphone_core_add_friend_list(cPtr, list.cPtr)
	}
	///	Add the given linphone specs to the list of functionalities the linphone client
	///	supports. 
	/// - Parameter spec: The spec to add 
	/// 
	public func addLinphoneSpec(spec:String) 
	{
		linphone_core_add_linphone_spec(cPtr, spec)
	}
	///	Add a proxy configuration. 
	/// This will start registration on the proxy, if registration is enabled. 
	public func addProxyConfig(config:ProxyConfig) throws 
	{
		let exception_result = linphone_core_add_proxy_config(cPtr, config.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addProxyConfig returned value \(exception_result)")
		}
	}
	///	This function controls signaling features supported by the core. 
	/// They are typically included in a SIP Supported header. 
	/// 
	/// - Parameter tag: The feature tag name 
	/// 
	public func addSupportedTag(tag:String) 
	{
		linphone_core_add_supported_tag(cPtr, tag)
	}
	///	Add a participant to the conference. 
	/// If no conference is going on a new internal conference context is created and
	/// the participant is added to it. 
	/// 
	/// - Parameter call: The current call with the participant to add 
	/// 
	/// 
	/// - Returns: 0 if succeeded. Negative number if failed 
	public func addToConference(call:Call) throws 
	{
		let exception_result = linphone_core_add_to_conference(cPtr, call.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addToConference returned value \(exception_result)")
		}
	}
	///	Special function to indicate if the audio route is changed. 
	/// Must be called in the callback of AVAudioSessionRouteChangeNotification. 
	public func audioRouteChanged() 
	{
		linphone_core_audio_route_changed(cPtr)
	}
	///	Checks if a new version of the application is available. 
	/// - Parameter currentVersion: The current version of the application 
	/// 
	public func checkForUpdate(currentVersion:String) 
	{
		linphone_core_check_for_update(cPtr, currentVersion)
	}
	///	Clear all authentication information. 
	public func clearAllAuthInfo() 
	{
		linphone_core_clear_all_auth_info(cPtr)
	}
	///	Erase the call log. 
	public func clearCallLogs() 
	{
		linphone_core_clear_call_logs(cPtr)
	}
	///	Erase all proxies from config. 
	public func clearProxyConfig() 
	{
		linphone_core_clear_proxy_config(cPtr)
	}
	///	Create a `AccountCreator` and set Linphone Request callbacks. 
	/// - Parameter xmlrpcUrl: The URL to the XML-RPC server. Must be NON nil. 
	/// 
	/// 
	/// - Returns: The new `AccountCreator` object. 
	public func createAccountCreator(xmlrpcUrl:String) throws -> AccountCreator
	{
		let cPointer = linphone_core_create_account_creator(cPtr, xmlrpcUrl)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null AccountCreator value")
		}
		return AccountCreator.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `Address` object by parsing the user supplied address, given as a
	///	string. 
	/// - Parameter address: String containing the user supplied address 
	/// 
	/// 
	/// - Returns: The create `Address` object 
	public func createAddress(address:String) throws -> Address
	{
		let cPointer = linphone_core_create_address(cPtr, address)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Address value")
		}
		return Address.getSwiftObject(cObject: cPointer!)
	}
	///	Create an authentication information with default values from Linphone core. 
	/// - Parameter username: String containing the username part of the authentication
	/// credentials 
	/// - Parameter userid: String containing the username to use to calculate the
	/// authentication digest (optional) 
	/// - Parameter passwd: String containing the password of the authentication
	/// credentials (optional, either passwd or ha1 must be set) 
	/// - Parameter ha1: String containing a ha1 hash of the password (optional, either
	/// passwd or ha1 must be set) 
	/// - Parameter realm: String used to discriminate different SIP authentication
	/// domains (optional) 
	/// - Parameter domain: String containing the SIP domain for which this
	/// authentication information is valid, if it has to be restricted for a single
	/// SIP domain. 
	/// 
	/// 
	/// - Returns: `AuthInfo` with default values set
	/// 
	/// - deprecated: use {@link Factory#createAuthInfo} instead. 
	public func createAuthInfo(username:String, userid:String, passwd:String, ha1:String, realm:String, domain:String) throws -> AuthInfo
	{
		let cPointer = linphone_core_create_auth_info(cPtr, username, userid, passwd, ha1, realm, domain)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null AuthInfo value")
		}
		return AuthInfo.getSwiftObject(cObject: cPointer!)
	}
	///	Creates a fake LinphoneCallLog. 
	/// - Parameter from: LinphoneAddress of caller 
	/// - Parameter to: LinphoneAddress of callee 
	/// - Parameter dir: LinphoneCallDir of call 
	/// - Parameter duration: call length in seconds 
	/// - Parameter startTime: timestamp of call start time 
	/// - Parameter connectedTime: timestamp of call connection 
	/// - Parameter status: LinphoneCallStatus of call 
	/// - Parameter videoEnabled: whether video was enabled or not for this call 
	/// - Parameter quality: call quality 
	/// 
	/// 
	/// - Returns: LinphoneCallLog object 
	public func createCallLog(from:Address, to:Address, dir:Call.Dir, duration:Int, startTime:time_t, connectedTime:time_t, status:Call.Status, videoEnabled:Bool, quality:Float) throws -> CallLog
	{
		let cPointer = linphone_core_create_call_log(cPtr, from.cPtr, to.cPtr, LinphoneCallDir(rawValue: CUnsignedInt(dir.rawValue)), CInt(duration), startTime, connectedTime, LinphoneCallStatus(rawValue: CUnsignedInt(status.rawValue)), videoEnabled==true ? 1:0, quality)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null CallLog value")
		}
		return CallLog.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `CallParams` suitable for {@link Core#inviteWithParams},
	///	linphone_core_accept_call_with_params,
	///	linphone_core_accept_early_media_with_params, linphone_core_accept_call_update. 
	/// The parameters are initialized according to the current `Core` configuration
	/// and the current state of the LinphoneCall. 
	/// 
	/// - Parameter call: `Call` for which the parameters are to be build, or nil in
	/// the case where the parameters are to be used for a new outgoing call.    
	/// 
	/// 
	/// - Returns: A new `CallParams` object 
	public func createCallParams(call:Call?) throws -> CallParams
	{
		let cPointer = linphone_core_create_call_params(cPtr, call?.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null CallParams value")
		}
		return CallParams.getSwiftObject(cObject: cPointer!)
	}
	///	Create a chat room. 
	/// - Parameter params: The chat room creation parameters `ChatRoomParams` 
	/// - Parameter participants: A list of `Address` objects. LinphoneAddress  The
	/// initial list of participants of the chat room 
	/// 
	/// 
	/// - Returns: The newly created chat room. 
	public func createChatRoom(params:ChatRoomParams, subject:String, participants:[Address]) throws -> ChatRoom
	{
		let cPointer = linphone_core_create_chat_room_2(cPtr, params.cPtr, subject, ObjectArrayToBctbxList(list: participants))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoom value")
		}
		return ChatRoom.getSwiftObject(cObject: cPointer!)
	}
	/// - Parameter subject: The subject of the group chat room 
	/// - Parameter participants: A list of `Address` objects. LinphoneAddress  The
	/// initial list of participants of the chat room 
	/// 
	/// 
	/// - Returns: The newly created chat room. 
	public func createChatRoom(subject:String, participants:[Address]) throws -> ChatRoom
	{
		let cPointer = linphone_core_create_chat_room_3(cPtr, subject, ObjectArrayToBctbxList(list: participants))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoom value")
		}
		return ChatRoom.getSwiftObject(cObject: cPointer!)
	}
	/// - Parameter params: The chat room creation parameters `ChatRoomParams` 
	/// - Parameter localAddr: `Address` representing the local proxy configuration to
	/// use for the chat room creation 
	/// - Parameter participant: `Address` representing the initial participant to add
	/// to the chat room 
	/// 
	/// 
	/// - Returns: The newly created chat room. 
	public func createChatRoom(params:ChatRoomParams, localAddr:Address, participant:Address) throws -> ChatRoom
	{
		let cPointer = linphone_core_create_chat_room_4(cPtr, params.cPtr, localAddr.cPtr, participant.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoom value")
		}
		return ChatRoom.getSwiftObject(cObject: cPointer!)
	}
	/// - Parameter participant: `Address` representing the initial participant to add
	/// to the chat room 
	/// 
	/// 
	/// - Returns: The newly created chat room. 
	public func createChatRoom(participant:Address) throws -> ChatRoom
	{
		let cPointer = linphone_core_create_chat_room_5(cPtr, participant.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoom value")
		}
		return ChatRoom.getSwiftObject(cObject: cPointer!)
	}
	///	Create a chat room. 
	/// - Parameter params: The chat room creation parameters `ChatRoomParams` 
	/// - Parameter localAddr: `Address` representing the local proxy configuration to
	/// use for the chat room creation 
	/// - Parameter subject: The subject of the group chat room 
	/// - Parameter participants: A list of `Address` objects. LinphoneAddress  The
	/// initial list of participants of the chat room 
	/// 
	/// 
	/// - Returns: The newly created chat room. 
	public func createChatRoom(params:ChatRoomParams, localAddr:Address, subject:String, participants:[Address]) throws -> ChatRoom
	{
		let cPointer = linphone_core_create_chat_room(cPtr, params.cPtr, localAddr.cPtr, subject, ObjectArrayToBctbxList(list: participants))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoom value")
		}
		return ChatRoom.getSwiftObject(cObject: cPointer!)
	}
	///	Create some default conference parameters for instanciating a a conference with
	///	{@link Core#createConferenceWithParams}. 
	/// - Returns: conference parameters. 
	public func createConferenceParams() throws -> ConferenceParams
	{
		let cPointer = linphone_core_create_conference_params(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ConferenceParams value")
		}
		return ConferenceParams.getSwiftObject(cObject: cPointer!)
	}
	///	Create a conference. 
	/// - Parameter params: Parameters of the conference. See `ConferenceParams`. 
	/// 
	/// 
	/// - Returns: A pointer on the freshly created conference. That object will be
	/// automatically freed by the core after calling {@link Core#terminateConference}. 
	public func createConferenceWithParams(params:ConferenceParams) throws -> Conference
	{
		let cPointer = linphone_core_create_conference_with_params(cPtr, params.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Conference value")
		}
		return Conference.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `Config` object from a user config file. 
	/// - Parameter filename: The filename of the config file to read to fill the
	/// instantiated `Config` 
	/// 
	public func createConfig(filename:String) throws -> Config
	{
		let cPointer = linphone_core_create_config(cPtr, filename)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Config value")
		}
		return Config.getSwiftObject(cObject: cPointer!)
	}
	///	Create a content with default values from Linphone core. 
	/// - Returns: `Content` object with default values set 
	public func createContent() throws -> Content
	{
		let cPointer = linphone_core_create_content(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Content value")
		}
		return Content.getSwiftObject(cObject: cPointer!)
	}
	///	Creates and returns the default chat room parameters. 
	/// - Returns: LinphoneChatRoomParams 
	public func createDefaultChatRoomParams() throws -> ChatRoomParams
	{
		let cPointer = linphone_core_create_default_chat_room_params(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoomParams value")
		}
		return ChatRoomParams.getSwiftObject(cObject: cPointer!)
	}
	///	Create a default LinphoneFriend. 
	/// - Returns: The created `Friend` object 
	public func createFriend() throws -> Friend
	{
		let cPointer = linphone_core_create_friend(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Friend value")
		}
		return Friend.getSwiftObject(cObject: cPointer!)
	}
	///	Create a new empty `FriendList` object. 
	/// - Returns: A new `FriendList` object. 
	public func createFriendList() throws -> FriendList
	{
		let cPointer = linphone_core_create_friend_list(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null FriendList value")
		}
		return FriendList.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `Friend` from the given address. 
	/// - Parameter address: A string containing the address to create the `Friend`
	/// from 
	/// 
	/// 
	/// - Returns: The created `Friend` object 
	public func createFriendWithAddress(address:String) throws -> Friend
	{
		let cPointer = linphone_core_create_friend_with_address(cPtr, address)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Friend value")
		}
		return Friend.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an empty info message. 
	/// - Returns: a new LinphoneInfoMessage.
	/// 
	/// The info message can later be filled with information using {@link
	/// InfoMessage#addHeader} or {@link InfoMessage#setContent}, and finally sent with
	/// linphone_core_send_info_message(). 
	public func createInfoMessage() throws -> InfoMessage
	{
		let cPointer = linphone_core_create_info_message(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null InfoMessage value")
		}
		return InfoMessage.getSwiftObject(cObject: cPointer!)
	}
	///	Create an independent media file player. 
	/// This player support WAVE and MATROSKA formats. 
	/// 
	/// - Parameter soundCardName: Playback sound card. If nil, the ringer sound card
	/// set in `Core` will be used 
	/// - Parameter videoDisplayName: Video display. If nil, the video display set in
	/// `Core` will be used 
	/// - Parameter windowId: Id of the drawing window. Depend of video out 
	/// 
	/// 
	/// - Returns: A pointer on the new instance. nil if faild. 
	public func createLocalPlayer(soundCardName:String, videoDisplayName:String, windowId:UnsafeMutableRawPointer?) throws -> Player
	{
		let cPointer = linphone_core_create_local_player(cPtr, soundCardName, videoDisplayName, windowId)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Player value")
		}
		return Player.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `MagicSearch` object. 
	/// - Returns: The create `MagicSearch` object 
	public func createMagicSearch() throws -> MagicSearch
	{
		let cPointer = linphone_core_create_magic_search(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null MagicSearch value")
		}
		return MagicSearch.getSwiftObject(cObject: cPointer!)
	}
	///	Create a new `NatPolicy` object with every policies being disabled. 
	/// - Returns: A new `NatPolicy` object. 
	public func createNatPolicy() throws -> NatPolicy
	{
		let cPointer = linphone_core_create_nat_policy(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null NatPolicy value")
		}
		return NatPolicy.getSwiftObject(cObject: cPointer!)
	}
	///	Create a new `NatPolicy` by reading the config of a `Core` according to the
	///	passed ref. 
	/// - Parameter ref: The reference of a NAT policy in the config of the `Core` 
	/// 
	/// 
	/// - Returns: A new `NatPolicy` object. 
	public func createNatPolicyFromConfig(ref:String) throws -> NatPolicy
	{
		let cPointer = linphone_core_create_nat_policy_from_config(cPtr, ref)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null NatPolicy value")
		}
		return NatPolicy.getSwiftObject(cObject: cPointer!)
	}
	///	Create an out-of-dialog notification, specifying the destination resource, the
	///	event name. 
	/// The notification can be send with {@link Event#notify}. 
	/// 
	/// - Parameter resource: the destination resource 
	/// - Parameter event: the event name 
	/// 
	/// 
	/// - Returns: a `Event` holding the context of the notification. 
	public func createNotify(resource:Address, event:String) throws -> Event
	{
		let cPointer = linphone_core_create_notify(cPtr, resource.cPtr, event)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Event value")
		}
		return Event.getSwiftObject(cObject: cPointer!)
	}
	///	Create a publish context for a one-shot publish. 
	/// After being created, the publish must be sent using {@link Event#sendPublish}.
	/// The `Event` is automatically terminated when the publish transaction is
	/// finished, either with success or failure. The application must not call {@link
	/// Event#terminate} for such one-shot publish. 
	/// 
	/// - Parameter resource: the resource uri for the event 
	/// - Parameter event: the event name 
	/// 
	/// 
	/// - Returns: the `Event` holding the context of the publish. 
	public func createOneShotPublish(resource:Address, event:String) throws -> Event
	{
		let cPointer = linphone_core_create_one_shot_publish(cPtr, resource.cPtr, event)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Event value")
		}
		return Event.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `PresenceActivity` with the given type and description. 
	/// - Parameter acttype: The LinphonePresenceActivityType to set for the activity. 
	/// - Parameter description: An additional description of the activity to set for
	/// the activity. Can be nil if no additional description is to be added. 
	/// 
	/// 
	/// - Returns: The created `PresenceActivity` object. 
	public func createPresenceActivity(acttype:PresenceActivityType, description:String) throws -> PresenceActivity
	{
		let cPointer = linphone_core_create_presence_activity(cPtr, LinphonePresenceActivityType(rawValue: CUnsignedInt(acttype.rawValue)), description)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresenceActivity value")
		}
		return PresenceActivity.getSwiftObject(cObject: cPointer!)
	}
	///	Create a default LinphonePresenceModel. 
	/// - Returns: The created `PresenceModel` object. 
	public func createPresenceModel() throws -> PresenceModel
	{
		let cPointer = linphone_core_create_presence_model(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresenceModel value")
		}
		return PresenceModel.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `PresenceModel` with the given activity type and activity description. 
	/// - Parameter acttype: The LinphonePresenceActivityType to set for the activity
	/// of the created model. 
	/// - Parameter description: An additional description of the activity to set for
	/// the activity. Can be nil if no additional description is to be added. 
	/// 
	/// 
	/// - Returns: The created `PresenceModel` object. 
	public func createPresenceModelWithActivity(acttype:PresenceActivityType, description:String) throws -> PresenceModel
	{
		let cPointer = linphone_core_create_presence_model_with_activity(cPtr, LinphonePresenceActivityType(rawValue: CUnsignedInt(acttype.rawValue)), description)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresenceModel value")
		}
		return PresenceModel.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `PresenceModel` with the given activity type, activity description,
	///	note content and note language. 
	/// - Parameter acttype: The LinphonePresenceActivityType to set for the activity
	/// of the created model. 
	/// - Parameter description: An additional description of the activity to set for
	/// the activity. Can be nil if no additional description is to be added. 
	/// - Parameter note: The content of the note to be added to the created model. 
	/// - Parameter lang: The language of the note to be added to the created model. 
	/// 
	/// 
	/// - Returns: The created `PresenceModel` object. 
	public func createPresenceModelWithActivityAndNote(acttype:PresenceActivityType, description:String, note:String, lang:String) throws -> PresenceModel
	{
		let cPointer = linphone_core_create_presence_model_with_activity_and_note(cPtr, LinphonePresenceActivityType(rawValue: CUnsignedInt(acttype.rawValue)), description, note, lang)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresenceModel value")
		}
		return PresenceModel.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `PresenceNote` with the given content and language. 
	/// - Parameter content: The content of the note to be created. 
	/// - Parameter lang: The language of the note to be created. 
	/// 
	/// 
	/// - Returns: The created `PresenceNote` object. 
	public func createPresenceNote(content:String, lang:String) throws -> PresenceNote
	{
		let cPointer = linphone_core_create_presence_note(cPtr, content, lang)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresenceNote value")
		}
		return PresenceNote.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `PresencePerson` with the given id. 
	/// - Parameter id: The id of the person to be created. 
	/// 
	/// 
	/// - Returns: The created `PresencePerson` object. 
	public func createPresencePerson(id:String) throws -> PresencePerson
	{
		let cPointer = linphone_core_create_presence_person(cPtr, id)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresencePerson value")
		}
		return PresencePerson.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `PresenceService` with the given id, basic status and contact. 
	/// - Parameter id: The id of the service to be created. 
	/// - Parameter basicStatus: The basic status of the service to be created. 
	/// - Parameter contact: A string containing a contact information corresponding to
	/// the service to be created. 
	/// 
	/// 
	/// - Returns: The created `PresenceService` object. 
	public func createPresenceService(id:String, basicStatus:PresenceBasicStatus, contact:String) throws -> PresenceService
	{
		let cPointer = linphone_core_create_presence_service(cPtr, id, LinphonePresenceBasicStatus(rawValue: CUnsignedInt(basicStatus.rawValue)), contact)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresenceService value")
		}
		return PresenceService.getSwiftObject(cObject: cPointer!)
	}
	///	Same as {@link Core#getPrimaryContact} but the result is a `Address` object
	///	instead of const char *. 
	public func createPrimaryContactParsed() throws -> Address
	{
		let cPointer = linphone_core_create_primary_contact_parsed(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Address value")
		}
		return Address.getSwiftObject(cObject: cPointer!)
	}
	///	Create a proxy config with default values from Linphone core. 
	/// - Returns: `ProxyConfig` with default values set 
	public func createProxyConfig() throws -> ProxyConfig
	{
		let cPointer = linphone_core_create_proxy_config(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ProxyConfig value")
		}
		return ProxyConfig.getSwiftObject(cObject: cPointer!)
	}
	///	Create a publish context for an event state. 
	/// After being created, the publish must be sent using {@link Event#sendPublish}.
	/// After expiry, the publication is refreshed unless it is terminated before. 
	/// 
	/// - Parameter resource: the resource uri for the event 
	/// - Parameter event: the event name 
	/// - Parameter expires: the lifetime of event being published, -1 if no associated
	/// duration, in which case it will not be refreshed. 
	/// 
	/// 
	/// - Returns: the `Event` holding the context of the publish. 
	public func createPublish(resource:Address, event:String, expires:Int) throws -> Event
	{
		let cPointer = linphone_core_create_publish(cPtr, resource.cPtr, event, CInt(expires))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Event value")
		}
		return Event.getSwiftObject(cObject: cPointer!)
	}
	///	Create an outgoing subscription, specifying the destination resource, the event
	///	name, and an optional content body. 
	/// If accepted, the subscription runs for a finite period, but is automatically
	/// renewed if not terminated before. Unlike {@link Core#subscribe} the
	/// subscription isn't sent immediately. It will be send when calling {@link
	/// Event#sendSubscribe}. 
	/// 
	/// - Parameter resource: the destination resource 
	/// - Parameter proxy: the proxy configuration to use 
	/// - Parameter event: the event name 
	/// - Parameter expires: the whished duration of the subscription 
	/// 
	/// 
	/// - Returns: a `Event` holding the context of the created subcription. 
	public func createSubscribe(resource:Address, proxy:ProxyConfig, event:String, expires:Int) throws -> Event
	{
		let cPointer = linphone_core_create_subscribe_2(cPtr, resource.cPtr, proxy.cPtr, event, CInt(expires))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Event value")
		}
		return Event.getSwiftObject(cObject: cPointer!)
	}
	///	Create an outgoing subscription, specifying the destination resource, the event
	///	name, and an optional content body. 
	/// If accepted, the subscription runs for a finite period, but is automatically
	/// renewed if not terminated before. Unlike {@link Core#subscribe} the
	/// subscription isn't sent immediately. It will be send when calling {@link
	/// Event#sendSubscribe}. 
	/// 
	/// - Parameter resource: the destination resource 
	/// - Parameter event: the event name 
	/// - Parameter expires: the whished duration of the subscription 
	/// 
	/// 
	/// - Returns: a `Event` holding the context of the created subcription. 
	public func createSubscribe(resource:Address, event:String, expires:Int) throws -> Event
	{
		let cPointer = linphone_core_create_subscribe(cPtr, resource.cPtr, event, CInt(expires))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Event value")
		}
		return Event.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `XmlRpcSession` for a given url. 
	/// - Parameter url: The URL to the XML-RPC server. Must be NON nil. 
	/// 
	/// 
	/// - Returns: The new `XmlRpcSession` object. 
	public func createXmlRpcSession(url:String) throws -> XmlRpcSession
	{
		let cPointer = linphone_core_create_xml_rpc_session(cPtr, url)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null XmlRpcSession value")
		}
		return XmlRpcSession.getSwiftObject(cObject: cPointer!)
	}
	///	Removes a chatroom including all message history from the LinphoneCore. 
	/// - Parameter cr: A `ChatRoom` object 
	/// 
	public func deleteChatRoom(cr:ChatRoom) 
	{
		linphone_core_delete_chat_room(cPtr, cr.cPtr)
	}
	///	Inconditionnaly disable incoming chat messages. 
	/// - Parameter denyReason: the deny reason (LinphoneReasonNone has no effect). 
	/// 
	public func disableChat(denyReason:Reason) 
	{
		linphone_core_disable_chat(cPtr, LinphoneReason(rawValue: CUnsignedInt(denyReason.rawValue)))
	}
	///	Enable reception of incoming chat messages. 
	/// By default it is enabled but it can be disabled with {@link Core#disableChat}. 
	public func enableChat() 
	{
		linphone_core_enable_chat(cPtr)
	}
	///	Call this method when you receive a push notification. 
	/// It will ensure the proxy configs are correctly registered to the proxy server,
	/// so the call or the message will be correctly delivered. 
	public func ensureRegistered() 
	{
		linphone_core_ensure_registered(cPtr)
	}
	///	This method is called by the application to notify the linphone core library
	///	when it enters background mode. 
	public func enterBackground() 
	{
		linphone_core_enter_background(cPtr)
	}
	///	Join the local participant to the running conference. 
	/// - Returns: 0 if succeeded. Negative number if failed 
	public func enterConference() throws 
	{
		let exception_result = linphone_core_enter_conference(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "enterConference returned value \(exception_result)")
		}
	}
	///	This method is called by the application to notify the linphone core library
	///	when it enters foreground mode. 
	public func enterForeground() 
	{
		linphone_core_enter_foreground(cPtr)
	}
	///	Returns whether a specific file format is supported. 
	/// - See also: linphone_core_get_supported_file_formats 
	/// 
	/// - Parameter fmt: The format extension (wav, mkv). 
	/// 
	public func fileFormatSupported(fmt:String) -> Bool
	{
		return linphone_core_file_format_supported(cPtr, fmt) != 0
	}
	///	Find authentication info matching realm, username, domain criteria. 
	/// First of all, (realm,username) pair are searched. If multiple results (which
	/// should not happen because realm are supposed to be unique), then domain is
	/// added to the search. 
	/// 
	/// - Parameter realm: the authentication 'realm' (optional) 
	/// - Parameter username: the SIP username to be authenticated (mandatory) 
	/// - Parameter sipDomain: the SIP domain name (optional) 
	/// 
	/// 
	/// - Returns: a `AuthInfo` 
	public func findAuthInfo(realm:String, username:String, sipDomain:String) -> AuthInfo?
	{
		let cPointer = linphone_core_find_auth_info(cPtr, realm, username, sipDomain)
		if (cPointer == nil) {
			return nil
		}
		return AuthInfo.getSwiftObject(cObject: cPointer!)
	}
	///	Search from the list of current calls if a remote address match uri. 
	/// - Parameter uri: which should match call remote uri 
	/// 
	/// 
	/// - Returns: `Call` or nil is no match is found 
	public func findCallFromUri(uri:String) -> Call?
	{
		let cPointer = linphone_core_find_call_from_uri(cPtr, uri)
		if (cPointer == nil) {
			return nil
		}
		return Call.getSwiftObject(cObject: cPointer!)
	}
	///	Get the call log matching the call id, or nil if can't be found. 
	/// - Parameter callId: Call id of the call log to find 
	/// 
	/// 
	/// - Returns: {LinphoneCallLog} 
	public func findCallLogFromCallId(callId:String) -> CallLog?
	{
		let cPointer = linphone_core_find_call_log_from_call_id(cPtr, callId)
		if (cPointer == nil) {
			return nil
		}
		return CallLog.getSwiftObject(cObject: cPointer!)
	}
	///	Find a chat room. 
	/// No reference is transfered to the application. The `Core` keeps a reference on
	/// the chat room. 
	/// 
	/// - Parameter peerAddr: a linphone address. 
	/// - Parameter localAddr: a linphone address. 
	/// 
	/// 
	/// - Returns: `ChatRoom` where messaging can take place. 
	public func findChatRoom(peerAddr:Address, localAddr:Address) -> ChatRoom?
	{
		let cPointer = linphone_core_find_chat_room(cPtr, peerAddr.cPtr, localAddr.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return ChatRoom.getSwiftObject(cObject: cPointer!)
	}
	///	Retrieves a list of `Address` sort and filter. 
	/// - Parameter filter: Chars used for the filter* 
	/// - Parameter sipOnly: Only sip address or not 
	/// 
	/// 
	/// - Returns: A list of `Address` objects. LinphoneAddress  a list of filtered
	/// `Address` + the `Address` created with the filter 
	public func findContactsByChar(filter:String, sipOnly:Bool) -> [Address]
	{
		var swiftList = [Address]()
		var cList = linphone_core_find_contacts_by_char(cPtr, filter, sipOnly==true ? 1:0)
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(Address.getSwiftObject(cObject: data))
			cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Search a `Friend` by its address. 
	/// - Parameter addr: The address to use to search the friend. 
	/// 
	/// 
	/// - Returns: The `Friend` object corresponding to the given address. 
	public func findFriend(addr:Address) -> Friend?
	{
		let cPointer = linphone_core_find_friend(cPtr, addr.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return Friend.getSwiftObject(cObject: cPointer!)
	}
	///	Search all `Friend` matching an address. 
	/// - Parameter addr: The address to use to search the friends. 
	/// 
	/// 
	/// - Returns: A list of `Friend` objects. LinphoneFriend  a list of `Friend`
	/// corresponding to the given address. 
	public func findFriends(addr:Address) -> [Friend]
	{
		var swiftList = [Friend]()
		var cList = linphone_core_find_friends(cPtr, addr.cPtr)
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(Friend.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Find a one to one chat room. 
	/// No reference is transfered to the application. The `Core` keeps a reference on
	/// the chat room. 
	/// 
	/// - Parameter localAddr: a linphone address. 
	/// - Parameter participantAddr: a linphone address. 
	/// - Parameter encrypted: whether to look for an encrypted chat room or not 
	/// 
	/// 
	/// - Returns: `ChatRoom` where messaging can take place. 
	public func findOneToOneChatRoom(localAddr:Address, participantAddr:Address, encrypted:Bool) -> ChatRoom?
	{
		let cPointer = linphone_core_find_one_to_one_chat_room_2(cPtr, localAddr.cPtr, participantAddr.cPtr, encrypted==true ? 1:0)
		if (cPointer == nil) {
			return nil
		}
		return ChatRoom.getSwiftObject(cObject: cPointer!)
	}
	///	Find a one to one chat room. 
	/// No reference is transfered to the application. The `Core` keeps a reference on
	/// the chat room. 
	/// 
	/// - Parameter localAddr: a linphone address. 
	/// - Parameter participantAddr: a linphone address. 
	/// 
	/// 
	/// - Returns: `ChatRoom` where messaging can take place. 
	/// 
	/// - deprecated: Use linphone_core_find_one_to_one_chat_room_2 instead 
	public func findOneToOneChatRoom(localAddr:Address, participantAddr:Address) -> ChatRoom?
	{
		let cPointer = linphone_core_find_one_to_one_chat_room(cPtr, localAddr.cPtr, participantAddr.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return ChatRoom.getSwiftObject(cObject: cPointer!)
	}
	///	Get the call with the remote_address specified. 
	/// - Parameter remoteAddress: The remote address of the call that we want to get 
	/// 
	/// 
	/// - Returns: The call if it has been found, nil otherwise    
	public func getCallByRemoteAddress(remoteAddress:String) -> Call?
	{
		let cPointer = linphone_core_get_call_by_remote_address(cPtr, remoteAddress)
		if (cPointer == nil) {
			return nil
		}
		return Call.getSwiftObject(cObject: cPointer!)
	}
	///	Get the call with the remote_address specified. 
	/// - Parameter remoteAddress: 
	/// 
	/// 
	/// - Returns: the `Call` of the call if found 
	public func getCallByRemoteAddress2(remoteAddress:Address) -> Call?
	{
		let cPointer = linphone_core_get_call_by_remote_address2(cPtr, remoteAddress.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return Call.getSwiftObject(cObject: cPointer!)
	}
	///	Get the list of call logs (past calls). 
	/// At the contrary of linphone_core_get_call_logs, it is your responsibility to
	/// unref the logs and free this list once you are done using it. 
	/// 
	/// - Parameter peerAddr: A `Address` object. 
	/// 
	/// 
	/// - Returns: A list of `CallLog` objects. LinphoneCallLog  The objects inside the
	/// list are freshly allocated with a reference counter equal to one, so they need
	/// to be freed on list destruction with bctbx_list_free_with_data() for instance. 
	///  
	public func getCallHistory(peerAddr:Address, localAddr:Address) -> [CallLog]
	{
		var swiftList = [CallLog]()
		var cList = linphone_core_get_call_history_2(cPtr, peerAddr.cPtr, localAddr.cPtr)
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(CallLog.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Get the list of call logs (past calls) that matches the given `Address`. 
	/// At the contrary of linphone_core_get_call_logs, it is your responsibility to
	/// unref the logs and free this list once you are done using it. 
	/// 
	/// - Parameter addr: `Address` object 
	/// 
	/// 
	/// - Returns: A list of `CallLog` objects. LinphoneCallLog  The objects inside the
	/// list are freshly allocated with a reference counter equal to one, so they need
	/// to be freed on list destruction with bctbx_list_free_with_data() for instance. 
	///  
	/// 
	/// - deprecated: Use linphone_core_get_call_history_2 instead. Deprecated since
	/// 2018-10-29. 
	public func getCallHistoryForAddress(addr:Address) -> [CallLog]
	{
		var swiftList = [CallLog]()
		var cList = linphone_core_get_call_history_for_address(cPtr, addr.cPtr)
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(CallLog.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Get a basic chat room. 
	/// If it does not exist yet, it will be created. No reference is transfered to the
	/// application. The `Core` keeps a reference on the chat room. 
	/// 
	/// - Parameter peerAddr: a linphone address. 
	/// - Parameter localAddr: a linphone address. 
	/// 
	/// 
	/// - Returns: `ChatRoom` where messaging can take place. 
	public func getChatRoom(peerAddr:Address, localAddr:Address) -> ChatRoom?
	{
		let cPointer = linphone_core_get_chat_room_2(cPtr, peerAddr.cPtr, localAddr.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return ChatRoom.getSwiftObject(cObject: cPointer!)
	}
	///	Get a basic chat room whose peer is the supplied address. 
	/// If it does not exist yet, it will be created. No reference is transfered to the
	/// application. The `Core` keeps a reference on the chat room. 
	/// 
	/// - Parameter addr: a linphone address. 
	/// 
	/// 
	/// - Returns: `ChatRoom` where messaging can take place. 
	public func getChatRoom(addr:Address) -> ChatRoom?
	{
		let cPointer = linphone_core_get_chat_room(cPtr, addr.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return ChatRoom.getSwiftObject(cObject: cPointer!)
	}
	///	Get a basic chat room for messaging from a sip uri like
	///	sip:joe@sip.linphone.org. 
	/// If it does not exist yet, it will be created. No reference is transfered to the
	/// application. The `Core` keeps a reference on the chat room. 
	/// 
	/// - Parameter to: The destination address for messages. 
	/// 
	/// 
	/// - Returns: `ChatRoom` where messaging can take place. 
	public func getChatRoomFromUri(to:String) -> ChatRoom?
	{
		let cPointer = linphone_core_get_chat_room_from_uri(cPtr, to)
		if (cPointer == nil) {
			return nil
		}
		return ChatRoom.getSwiftObject(cObject: cPointer!)
	}
	///	Search a `Friend` by its reference key. 
	/// - Parameter key: The reference key to use to search the friend. 
	/// 
	/// 
	/// - Returns: The `Friend` object corresponding to the given reference key. 
	public func getFriendByRefKey(key:String) -> Friend?
	{
		let cPointer = linphone_core_get_friend_by_ref_key(cPtr, key)
		if (cPointer == nil) {
			return nil
		}
		return Friend.getSwiftObject(cObject: cPointer!)
	}
	///	Retrieves the list of `Friend` from the core that has the given display name. 
	/// - Parameter name: the name of the list 
	/// 
	/// 
	/// - Returns: the first `FriendList` object or nil 
	public func getFriendListByName(name:String) -> FriendList?
	{
		let cPointer = linphone_core_get_friend_list_by_name(cPtr, name)
		if (cPointer == nil) {
			return nil
		}
		return FriendList.getSwiftObject(cObject: cPointer!)
	}
	///	Get the chat room we have been added into using the chat_room_addr included in
	///	the push notification body This will start the core given in parameter, iterate
	///	until the new chat room is received and return it. 
	/// By default, after 25 seconds the function returns because iOS kills the app
	/// extension after 30 seconds. 
	/// 
	/// - Parameter chatRoomAddr: The sip address of the chat room 
	/// 
	/// 
	/// - Returns: The `ChatRoom` object. 
	public func getNewChatRoomFromConfAddr(chatRoomAddr:String) -> ChatRoom?
	{
		let cPointer = linphone_core_get_new_chat_room_from_conf_addr(cPtr, chatRoomAddr)
		if (cPointer == nil) {
			return nil
		}
		return ChatRoom.getSwiftObject(cObject: cPointer!)
	}
	///	Get the chat message with the call_id included in the push notification body
	///	This will start the core given in parameter, iterate until the message is
	///	received and return it. 
	/// By default, after 25 seconds the function returns because iOS kills the app
	/// extension after 30 seconds. 
	/// 
	/// - Parameter callId: The callId of the Message SIP transaction 
	/// 
	/// 
	/// - Returns: The `ChatMessage` object. 
	public func getNewMessageFromCallid(callId:String) -> PushNotificationMessage?
	{
		let cPointer = linphone_core_get_new_message_from_callid(cPtr, callId)
		if (cPointer == nil) {
			return nil
		}
		return PushNotificationMessage.getSwiftObject(cObject: cPointer!)
	}
	///	Get payload type from mime type and clock rate. 
	/// This function searches in audio and video codecs for the given payload type
	/// name and clockrate. 
	/// 
	/// - Parameter type: payload mime type (I.E SPEEX, PCMU, VP8) 
	/// - Parameter rate: can be LINPHONE_FIND_PAYLOAD_IGNORE_RATE 
	/// - Parameter channels: number of channels, can be
	/// LINPHONE_FIND_PAYLOAD_IGNORE_CHANNELS 
	/// 
	/// 
	/// - Returns: Returns nil if not found. If a `PayloadType` is returned, it must be
	/// released with linphone_payload_type_unref after using it. 
	/// 
	/// - Warning: The returned payload type is allocated as a floating reference i.e.
	/// the reference counter is initialized to 0. 
	public func getPayloadType(type:String, rate:Int, channels:Int) -> PayloadType?
	{
		let cPointer = linphone_core_get_payload_type(cPtr, type, CInt(rate), CInt(channels))
		if (cPointer == nil) {
			return nil
		}
		return PayloadType.getSwiftObject(cObject: cPointer!)
	}
	/// - Parameter idkey: An arbitrary idkey string associated to a proxy
	/// configuration 
	/// 
	/// 
	/// - Returns: the proxy configuration for the given idkey value, or nil if none
	/// found 
	public func getProxyConfigByIdkey(idkey:String) -> ProxyConfig?
	{
		let cPointer = linphone_core_get_proxy_config_by_idkey(cPtr, idkey)
		if (cPointer == nil) {
			return nil
		}
		return ProxyConfig.getSwiftObject(cObject: cPointer!)
	}
	///	Return the unread chat message count for a given local address. 
	/// - Parameter address: `Address` object. 
	/// 
	/// 
	/// - Returns: The unread chat message count. 
	public func getUnreadChatMessageCountFromLocal(address:Address) -> Int
	{
		return Int(linphone_core_get_unread_chat_message_count_from_local(cPtr, address.cPtr))
	}
	///	Get the zrtp sas validation status for a peer uri. 
	/// Once the SAS has been validated or rejected, the status will never return to
	/// Unknown (unless you delete your cache) 
	/// 
	/// - Parameter addr: the peer uri
	/// 
	/// 
	/// - Returns: - LinphoneZrtpPeerStatusUnknown: this uri is not present in cache OR
	/// during calls with the active device, SAS never was validated or rejected
	/// 
	public func getZrtpStatus(addr:String) -> ZrtpPeerStatus
	{
		return ZrtpPeerStatus(rawValue: Int(linphone_core_get_zrtp_status(cPtr, addr).rawValue))!
	}
	///	Check whether the device has a hardware echo canceller. 
	/// - Returns:  if it does, true otherwise 
	public func hasBuiltinEchoCanceller() -> Bool
	{
		return linphone_core_has_builtin_echo_canceller(cPtr) != 0
	}
	///	Check whether the device is flagged has crappy opengl. 
	/// - Returns:  if crappy opengl flag is set, true otherwise 
	public func hasCrappyOpengl() -> Bool
	{
		return linphone_core_has_crappy_opengl(cPtr) != 0
	}
	///	Tells whether there is a call running. 
	/// - Returns: A boolean value telling whether a call is currently running or not 
	public func inCall() -> Bool
	{
		return linphone_core_in_call(cPtr) != 0
	}
	///	See linphone_proxy_config_normalize_sip_uri for documentation. 
	/// Default proxy config is used to parse the address. 
	public func interpretUrl(url:String) -> Address?
	{
		let cPointer = linphone_core_interpret_url(cPtr, url)
		if (cPointer == nil) {
			return nil
		}
		return Address.getSwiftObject(cObject: cPointer!)
	}
	///	Initiates an outgoing call. 
	/// The application doesn't own a reference to the returned LinphoneCall object.
	/// Use linphone_call_ref to safely keep the LinphoneCall pointer valid within your
	/// application.
	/// 
	/// - Parameter url: The destination of the call (sip address, or phone number). 
	/// 
	/// 
	/// - Returns: A `Call` object or nil in case of failure 
	public func invite(url:String) -> Call?
	{
		let cPointer = linphone_core_invite(cPtr, url)
		if (cPointer == nil) {
			return nil
		}
		return Call.getSwiftObject(cObject: cPointer!)
	}
	///	Initiates an outgoing call given a destination `Address` The `Address` can be
	///	constructed directly using linphone_address_new, or created by {@link
	///	Core#interpretUrl}. 
	/// The application doesn't own a reference to the returned `Call` object. Use
	/// linphone_call_ref to safely keep the `Call` pointer valid within your
	/// application. 
	/// 
	/// - Parameter addr: The destination of the call (sip address). 
	/// 
	/// 
	/// - Returns: A `Call` object or nil in case of failure 
	public func inviteAddress(addr:Address) -> Call?
	{
		let cPointer = linphone_core_invite_address(cPtr, addr.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return Call.getSwiftObject(cObject: cPointer!)
	}
	///	Initiates an outgoing call given a destination `Address` The `Address` can be
	///	constructed directly using linphone_address_new, or created by {@link
	///	Core#interpretUrl}. 
	/// The application doesn't own a reference to the returned `Call` object. Use
	/// linphone_call_ref to safely keep the `Call` pointer valid within your
	/// application. 
	/// 
	/// - Parameter addr: The destination of the call (sip address). 
	/// - Parameter params: Call parameters 
	/// 
	/// 
	/// - Returns: A `Call` object or nil in case of failure 
	public func inviteAddressWithParams(addr:Address, params:CallParams) -> Call?
	{
		let cPointer = linphone_core_invite_address_with_params(cPtr, addr.cPtr, params.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return Call.getSwiftObject(cObject: cPointer!)
	}
	///	Initiates an outgoing call according to supplied call parameters The
	///	application doesn't own a reference to the returned `Call` object. 
	/// Use linphone_call_ref to safely keep the `Call` pointer valid within your
	/// application. 
	/// 
	/// - Parameter url: The destination of the call (sip address, or phone number). 
	/// - Parameter params: Call parameters 
	/// 
	/// 
	/// - Returns: A `Call` object or nil in case of failure 
	public func inviteWithParams(url:String, params:CallParams) -> Call?
	{
		let cPointer = linphone_core_invite_with_params(cPtr, url, params.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return Call.getSwiftObject(cObject: cPointer!)
	}
	///	Checks if the given media filter is loaded and usable. 
	/// This is for advanced users of the library, mainly to expose mediastreamer video
	/// filter status. 
	/// 
	/// - Parameter filtername: the filter name 
	/// 
	/// 
	/// - Returns: true if the filter is loaded and usable, false otherwise 
	public func isMediaFilterSupported(filtername:String) -> Bool
	{
		return linphone_core_is_media_filter_supported(cPtr, filtername) != 0
	}
	///	Main loop function. 
	/// It is crucial that your application call it periodically.
	/// 
	/// {@link Core#iterate} performs various backgrounds tasks:
	/// 
	public func iterate() 
	{
		linphone_core_iterate(cPtr)
	}
	///	Make the local participant leave the running conference. 
	/// - Returns: 0 if succeeded. Negative number if failed 
	public func leaveConference() throws 
	{
		let exception_result = linphone_core_leave_conference(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "leaveConference returned value \(exception_result)")
		}
	}
	///	Tells if LIME X3DH is available. 
	public func limeX3DhAvailable() -> Bool
	{
		return linphone_core_lime_x3dh_available(cPtr) != 0
	}
	///	Update current config with the content of a xml config file. 
	/// - Parameter xmlUri: the path to the xml file 
	/// 
	public func loadConfigFromXml(xmlUri:String) 
	{
		linphone_core_load_config_from_xml(cPtr, xmlUri)
	}
	///	Check if a media encryption type is supported. 
	/// - Parameter menc: LinphoneMediaEncryption 
	/// 
	/// 
	/// - Returns: whether a media encryption scheme is supported by the `Core` engine 
	public func mediaEncryptionSupported(menc:MediaEncryption) -> Bool
	{
		return linphone_core_media_encryption_supported(cPtr, LinphoneMediaEncryption(rawValue: CUnsignedInt(menc.rawValue))) != 0
	}
	///	Migrates the call logs from the linphonerc to the database if not done yet. 
	public func migrateLogsFromRcToDb() 
	{
		linphone_core_migrate_logs_from_rc_to_db(cPtr)
	}
	///	Migrate configuration so that all SIP transports are enabled. 
	/// Versions of linphone < 3.7 did not support using multiple SIP transport
	/// simultaneously. This function helps application to migrate the configuration so
	/// that all transports are enabled. Existing proxy configuration are added a
	/// transport parameter so that they continue using the unique transport that was
	/// set previously. This function must be used just after creating the core, before
	/// any call to {@link Core#iterate} 
	/// 
	/// - Returns: 1 if migration was done, 0 if not done because unnecessary or
	/// already done, -1 in case of error. 
	public func migrateToMultiTransport() throws 
	{
		let exception_result = linphone_core_migrate_to_multi_transport(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "migrateToMultiTransport returned value \(exception_result)")
		}
	}
	///	Notify all friends that have subscribed. 
	/// - Parameter presence: `PresenceModel` to notify 
	/// 
	public func notifyAllFriends(presence:PresenceModel) 
	{
		linphone_core_notify_all_friends(cPtr, presence.cPtr)
	}
	///	Notifies the upper layer that a presence status has been received by calling
	///	the appropriate callback if one has been set. 
	/// This method is for advanced usage, where customization of the liblinphone's
	/// internal behavior is required. 
	/// 
	/// - Parameter lf: the `Friend` whose presence information has been received. 
	/// 
	public func notifyNotifyPresenceReceived(lf:Friend) 
	{
		linphone_core_notify_notify_presence_received(cPtr, lf.cPtr)
	}
	///	Notifies the upper layer that a presence model change has been received for the
	///	uri or telephone number given as a parameter, by calling the appropriate
	///	callback if one has been set. 
	/// This method is for advanced usage, where customization of the liblinphone's
	/// internal behavior is required. 
	/// 
	/// - Parameter lf: the `Friend` whose presence information has been received. 
	/// - Parameter uriOrTel: telephone number or sip uri 
	/// - Parameter presenceModel: the `PresenceModel` that has been modified 
	/// 
	public func notifyNotifyPresenceReceivedForUriOrTel(lf:Friend, uriOrTel:String, presenceModel:PresenceModel) 
	{
		linphone_core_notify_notify_presence_received_for_uri_or_tel(cPtr, lf.cPtr, uriOrTel, presenceModel.cPtr)
	}
	///	Pause all currently running calls. 
	/// - Returns: 0 
	public func pauseAllCalls() throws 
	{
		let exception_result = linphone_core_pause_all_calls(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "pauseAllCalls returned value \(exception_result)")
		}
	}
	///	Plays a dtmf sound to the local user. 
	/// - Parameter dtmf: DTMF to play ['0'..'16'] | '#' | '#' 
	/// - Parameter durationMs: Duration in ms, -1 means play until next further call
	/// to {@link Core#stopDtmf} 
	/// 
	public func playDtmf(dtmf:CChar, durationMs:Int) 
	{
		linphone_core_play_dtmf(cPtr, dtmf, CInt(durationMs))
	}
	///	Plays an audio file to the local user. 
	/// This function works at any time, during calls, or when no calls are running. It
	/// doesn't request the underlying audio system to support multiple playback
	/// streams. 
	/// 
	/// - Parameter audiofile: The path to an audio file in wav PCM 16 bit format 
	/// 
	/// 
	/// - Returns: 0 on success, -1 on error 
	public func playLocal(audiofile:String) throws 
	{
		let exception_result = linphone_core_play_local(cPtr, audiofile)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "playLocal returned value \(exception_result)")
		}
	}
	///	Call generic OpenGL render for a given core. 
	public func previewOglRender() 
	{
		linphone_core_preview_ogl_render(cPtr)
	}
	///	Publish an event state. 
	/// This first create a `Event` with {@link Core#createPublish} and calls {@link
	/// Event#sendPublish} to actually send it. After expiry, the publication is
	/// refreshed unless it is terminated before. 
	/// 
	/// - Parameter resource: the resource uri for the event 
	/// - Parameter event: the event name 
	/// - Parameter expires: the lifetime of event being published, -1 if no associated
	/// duration, in which case it will not be refreshed. 
	/// - Parameter body: the actual published data 
	/// 
	/// 
	/// - Returns: the `Event` holding the context of the publish. 
	public func publish(resource:Address, event:String, expires:Int, body:Content) -> Event?
	{
		let cPointer = linphone_core_publish(cPtr, resource.cPtr, event, CInt(expires), body.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return Event.getSwiftObject(cObject: cPointer!)
	}
	///	Gets keep alive interval of real time text. 
	/// - Returns: keep alive interval of real time text. 
	public func realtimeTextGetKeepaliveInterval() -> UInt
	{
		return UInt(linphone_core_realtime_text_get_keepalive_interval(cPtr))
	}
	///	Set keep alive interval for real time text. 
	/// - Parameter interval: The keep alive interval of real time text, 25000 by
	/// default. 
	/// 
	public func realtimeTextSetKeepaliveInterval(interval:UInt) 
	{
		linphone_core_realtime_text_set_keepalive_interval(cPtr, CUnsignedInt(interval))
	}
	///	force registration refresh to be initiated upon next iterate 
	public func refreshRegisters() 
	{
		linphone_core_refresh_registers(cPtr)
	}
	///	Black list a friend. 
	/// same as {@link Friend#setIncSubscribePolicy} with LinphoneSPDeny policy; 
	/// 
	/// - Parameter lf: `Friend` to add 
	/// 
	public func rejectSubscriber(lf:Friend) 
	{
		linphone_core_reject_subscriber(cPtr, lf.cPtr)
	}
	///	Reload mediastreamer2 plugins from specified directory. 
	/// - Parameter path: the path from where plugins are to be loaded, pass nil to use
	/// default (compile-time determined) plugin directory. 
	/// 
	public func reloadMsPlugins(path:String) 
	{
		linphone_core_reload_ms_plugins(cPtr, path)
	}
	///	Update detection of sound devices. 
	/// Use this function when the application is notified of USB plug events, so that
	/// list of available hardwares for sound playback and capture is updated. 
	public func reloadSoundDevices() 
	{
		linphone_core_reload_sound_devices(cPtr)
	}
	///	Update detection of camera devices. 
	/// Use this function when the application is notified of USB plug events, so that
	/// list of available hardwares for video capture is updated. 
	public func reloadVideoDevices() 
	{
		linphone_core_reload_video_devices(cPtr)
	}
	///	Removes an authentication information object. 
	/// - Parameter info: The `AuthInfo` to remove. 
	/// 
	public func removeAuthInfo(info:AuthInfo) 
	{
		linphone_core_remove_auth_info(cPtr, info.cPtr)
	}
	///	Remove a specific call log from call history list. 
	/// This function destroys the call log object. It must not be accessed anymore by
	/// the application after calling this function. 
	/// 
	/// - Parameter callLog: `CallLog` object to remove. 
	/// 
	public func removeCallLog(callLog:CallLog) 
	{
		linphone_core_remove_call_log(cPtr, callLog.cPtr)
	}
	///	Removes a friend list. 
	/// - Parameter list: `FriendList` object 
	/// 
	public func removeFriendList(list:FriendList) 
	{
		linphone_core_remove_friend_list(cPtr, list.cPtr)
	}
	///	Remove a call from the conference. 
	/// - Parameter call: a call that has been previously merged into the conference.
	/// 
	/// 
	/// After removing the remote participant belonging to the supplied call, the call
	/// becomes a normal call in paused state. If one single remote participant is left
	/// alone together with the local user in the conference after the removal, then
	/// the conference is automatically transformed into a simple call in
	/// StreamsRunning state. The conference's resources are then automatically
	/// destroyed.
	/// 
	/// In other words, unless {@link Core#leaveConference} is explicitly called, the
	/// last remote participant of a conference is automatically put in a simple call
	/// in running state.
	/// 
	/// - Returns: 0 if successful, -1 otherwise. 
	public func removeFromConference(call:Call) throws 
	{
		let exception_result = linphone_core_remove_from_conference(cPtr, call.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "removeFromConference returned value \(exception_result)")
		}
	}
	///	Remove the given linphone specs from the list of functionalities the linphone
	///	client supports. 
	/// - Parameter spec: The spec to remove 
	/// 
	public func removeLinphoneSpec(spec:String) 
	{
		linphone_core_remove_linphone_spec(cPtr, spec)
	}
	///	Removes a proxy configuration. 
	/// `Core` will then automatically unregister and place the proxy configuration on
	/// a deleted list. For that reason, a removed proxy does NOT need to be freed. 
	public func removeProxyConfig(config:ProxyConfig) 
	{
		linphone_core_remove_proxy_config(cPtr, config.cPtr)
	}
	///	Remove a supported tag. 
	/// - Parameter tag: The tag to remove
	/// 
	/// 
	/// - See also: {@link Core#addSupportedTag} 
	public func removeSupportedTag(tag:String) 
	{
		linphone_core_remove_supported_tag(cPtr, tag)
	}
	///	Reset the counter of missed calls. 
	public func resetMissedCallsCount() 
	{
		linphone_core_reset_missed_calls_count(cPtr)
	}
	///	Sets the UDP port range from which to randomly select the port used for audio
	///	streaming. 
	/// - Parameter minPort: The lower bound of the audio port range to use 
	/// - Parameter maxPort: The upper bound of the audio port range to use 
	/// 
	public func setAudioPortRange(minPort:Int, maxPort:Int) 
	{
		linphone_core_set_audio_port_range(cPtr, CInt(minPort), CInt(maxPort))
	}
	///	Assign an audio file to be played locally upon call failure, for a given
	///	reason. 
	/// - Parameter reason: the LinphoneReason representing the failure error code. 
	/// - Parameter audiofile: a wav file to be played when such call failure happens. 
	/// 
	public func setCallErrorTone(reason:Reason, audiofile:String) 
	{
		linphone_core_set_call_error_tone(cPtr, LinphoneReason(rawValue: CUnsignedInt(reason.rawValue)), audiofile)
	}
	///	Set the rectangle where the decoder will search a QRCode. 
	/// - Parameter x: axis 
	/// - Parameter y: axis 
	/// - Parameter w: width 
	/// - Parameter h: height 
	/// 
	public func setQrcodeDecodeRect(x:Int, y:Int, w:Int, h:Int) 
	{
		linphone_core_set_qrcode_decode_rect(cPtr, CInt(x), CInt(y), CInt(w), CInt(h))
	}
	///	Sets the UDP port range from which to randomly select the port used for text
	///	streaming. 
	/// - Parameter minPort: The lower bound of the text port range to use 
	/// - Parameter maxPort: The upper bound of the text port range to use 
	/// 
	public func setTextPortRange(minPort:Int, maxPort:Int) 
	{
		linphone_core_set_text_port_range(cPtr, CInt(minPort), CInt(maxPort))
	}
	///	Set the user agent string used in SIP messages. 
	/// Set the user agent string used in SIP messages as "[ua_name]/[version]". No
	/// slash character will be printed if nil is given to "version". If nil is given
	/// to "ua_name" and "version" both, the User-agent header will be empty.
	/// 
	/// This function should be called just after linphone_factory_create_core ideally. 
	/// 
	/// - Parameter uaName: Name of the user agent. 
	/// - Parameter version: Version of the user agent. 
	/// 
	public func setUserAgent(uaName:String, version:String) 
	{
		linphone_core_set_user_agent(cPtr, uaName, version)
	}
	///	Sets the UDP port range from which to randomly select the port used for video
	///	streaming. 
	/// - Parameter minPort: The lower bound of the video port range to use 
	/// - Parameter maxPort: The upper bound of the video port range to use 
	/// 
	public func setVideoPortRange(minPort:Int, maxPort:Int) 
	{
		linphone_core_set_video_port_range(cPtr, CInt(minPort), CInt(maxPort))
	}
	///	Tells whether a specified sound device can capture sound. 
	/// - Parameter device: the device name as returned by
	/// linphone_core_get_sound_devices 
	/// 
	/// 
	/// - Returns: A boolean value telling whether the specified sound device can
	/// capture sound 
	public func soundDeviceCanCapture(device:String) -> Bool
	{
		return linphone_core_sound_device_can_capture(cPtr, device) != 0
	}
	///	Tells whether a specified sound device can play sound. 
	/// - Parameter device: the device name as returned by
	/// linphone_core_get_sound_devices 
	/// 
	/// 
	/// - Returns: A boolean value telling whether the specified sound device can play
	/// sound 
	public func soundDeviceCanPlayback(device:String) -> Bool
	{
		return linphone_core_sound_device_can_playback(cPtr, device) != 0
	}
	///	Check if a call will need the sound resources in near future (typically an
	///	outgoing call that is awaiting response). 
	/// In liblinphone, it is not possible to have two independant calls using sound
	/// device or camera at the same time. In order to prevent this situation, an
	/// application can use {@link Core#soundResourcesLocked} to know whether it is
	/// possible at a given time to start a new outgoing call. When the function
	/// returns true, an application should not allow the user to start an outgoing
	/// call. 
	/// 
	/// - Returns: A boolean value telling whether a call will need the sound resources
	/// in near future 
	public func soundResourcesLocked() -> Bool
	{
		return linphone_core_sound_resources_locked(cPtr) != 0
	}
	///	Start a `Core` object after it has been instantiated and not automatically
	///	started. 
	/// Also re-initialize a `Core` object that has been stopped using {@link
	/// Core#stop}. Must be called only if LinphoneGlobalState is either Ready of Off.
	/// State will changed to Startup, Configuring and then On.
	/// 
	/// - Returns: 0: success, -1: global failure, -2: could not connect database 
	public func start() throws 
	{
		let exception_result = linphone_core_start(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "start returned value \(exception_result)")
		}
	}
	///	Start recording the running conference. 
	/// - Parameter path: Path to the file where the recording will be written 
	/// 
	/// 
	/// - Returns: 0 if succeeded. Negative number if failed 
	public func startConferenceRecording(path:String) throws 
	{
		let exception_result = linphone_core_start_conference_recording(cPtr, path)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "startConferenceRecording returned value \(exception_result)")
		}
	}
	///	Special function to warm up dtmf feeback stream. 
	/// linphone_core_stop_dtmf_stream must() be called before entering FG mode 
	public func startDtmfStream() 
	{
		linphone_core_start_dtmf_stream(cPtr)
	}
	///	Starts an echo calibration of the sound devices, in order to find adequate
	///	settings for the echo canceler automatically. 
	/// - Returns: LinphoneStatus whether calibration has started or not. 
	public func startEchoCancellerCalibration() throws 
	{
		let exception_result = linphone_core_start_echo_canceller_calibration(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "startEchoCancellerCalibration returned value \(exception_result)")
		}
	}
	///	Start the simulation of call to test the latency with an external device. 
	/// - Parameter rate: Sound sample rate. 
	/// 
	public func startEchoTester(rate:UInt) throws 
	{
		let exception_result = linphone_core_start_echo_tester(cPtr, CUnsignedInt(rate))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "startEchoTester returned value \(exception_result)")
		}
	}
	///	Stop a `Core` object after it has been instantiated and started. 
	/// If stopped, it can be started again using {@link Core#start}. Must be called
	/// only if LinphoneGlobalState is either On. State will changed to Shutdown and
	/// then Off.
	public func stop() 
	{
		linphone_core_stop(cPtr)
	}
	///	Stop asynchronously a `Core` object after it has been instantiated and started. 
	/// State changes to Shutdown then {@link Core#iterate} must be called to allow the
	/// Core to end asynchronous tasks (terminate call, etc.). When all tasks are
	/// finished, State will change to Off. Must be called only if LinphoneGlobalState
	/// is On. When LinphoneGlobalState is Off `Core` can be started again using {@link
	/// Core#start}.
	public func stopAsync() 
	{
		linphone_core_stop_async(cPtr)
	}
	///	Stop recording the running conference. 
	/// - Returns: 0 if succeeded. Negative number if failed 
	public func stopConferenceRecording() throws 
	{
		let exception_result = linphone_core_stop_conference_recording(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "stopConferenceRecording returned value \(exception_result)")
		}
	}
	///	Stops playing a dtmf started by {@link Core#playDtmf}. 
	public func stopDtmf() 
	{
		linphone_core_stop_dtmf(cPtr)
	}
	///	Special function to stop dtmf feed back function. 
	/// Must be called before entering BG mode 
	public func stopDtmfStream() 
	{
		linphone_core_stop_dtmf_stream(cPtr)
	}
	///	Stop the simulation of call. 
	public func stopEchoTester() throws 
	{
		let exception_result = linphone_core_stop_echo_tester(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "stopEchoTester returned value \(exception_result)")
		}
	}
	///	Whenever the liblinphone is playing a ring to advertise an incoming call or
	///	ringback of an outgoing call, this function stops the ringing. 
	/// Typical use is to stop ringing when the user requests to ignore the call. 
	public func stopRinging() 
	{
		linphone_core_stop_ringing(cPtr)
	}
	///	Create an outgoing subscription, specifying the destination resource, the event
	///	name, and an optional content body. 
	/// If accepted, the subscription runs for a finite period, but is automatically
	/// renewed if not terminated before. 
	/// 
	/// - Parameter resource: the destination resource 
	/// - Parameter event: the event name 
	/// - Parameter expires: the whished duration of the subscription 
	/// - Parameter body: an optional body, may be nil.    
	/// 
	/// 
	/// - Returns: a `Event` holding the context of the created subcription. 
	public func subscribe(resource:Address, event:String, expires:Int, body:Content?) -> Event?
	{
		let cPointer = linphone_core_subscribe(cPtr, resource.cPtr, event, CInt(expires), body?.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return Event.getSwiftObject(cObject: cPointer!)
	}
	///	Take a photo of currently from capture device and write it into a jpeg file. 
	/// Note that the snapshot is asynchronous, an application shall not assume that
	/// the file is created when the function returns.
	/// 
	/// - Parameter file: a path where to write the jpeg content. 
	/// 
	/// 
	/// - Returns: 0 if successfull, -1 otherwise (typically if jpeg format is not
	/// supported). 
	public func takePreviewSnapshot(file:String) throws 
	{
		let exception_result = linphone_core_take_preview_snapshot(cPtr, file)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "takePreviewSnapshot returned value \(exception_result)")
		}
	}
	///	Terminates all the calls. 
	/// - Returns: 0 
	public func terminateAllCalls() throws 
	{
		let exception_result = linphone_core_terminate_all_calls(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "terminateAllCalls returned value \(exception_result)")
		}
	}
	///	Terminate the running conference. 
	/// If it is a local conference, all calls inside it will become back separate
	/// calls and will be put in #LinphoneCallPaused state. If it is a conference
	/// involving a focus server, all calls inside the conference will be terminated. 
	/// 
	/// - Returns: 0 if succeeded. Negative number if failed 
	public func terminateConference() throws 
	{
		let exception_result = linphone_core_terminate_conference(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "terminateConference returned value \(exception_result)")
		}
	}
	///	Upload the log collection to the configured server url. 
	public func uploadLogCollection() 
	{
		linphone_core_upload_log_collection(cPtr)
	}
	///	Tells the core to use a separate window for local camera preview video, instead
	///	of inserting local view within the remote video window. 
	/// - Parameter yesno:  to use a separate window, true to insert the preview in the
	/// remote video window. 
	/// 
	public func usePreviewWindow(yesno:Bool) 
	{
		linphone_core_use_preview_window(cPtr, yesno==true ? 1:0)
	}
	///	Specify whether the tls server certificate must be verified when connecting to
	///	a SIP/TLS server. 
	/// - Parameter yesno: A boolean value telling whether the tls server certificate
	/// must be verified 
	/// 
	public func verifyServerCertificates(yesno:Bool) 
	{
		linphone_core_verify_server_certificates(cPtr, yesno==true ? 1:0)
	}
	///	Specify whether the tls server certificate common name must be verified when
	///	connecting to a SIP/TLS server. 
	/// - Parameter yesno: A boolean value telling whether the tls server certificate
	/// common name must be verified 
	/// 
	public func verifyServerCn(yesno:Bool) 
	{
		linphone_core_verify_server_cn(cPtr, yesno==true ? 1:0)
	}
	///	Test if video is supported. 
	public func videoSupported() -> Bool
	{
		return linphone_core_video_supported(cPtr) != 0
	}
}

/// Represents a dial plan. 
public class DialPlan : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> DialPlan {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<DialPlan>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = DialPlan(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///	Find best match for given CCC. 
	/// - Returns: Return matching dial plan, or a generic one if none found 
	static public func byCcc(ccc:String) -> DialPlan?
	{
		let cPointer = linphone_dial_plan_by_ccc(ccc)
		if (cPointer == nil) {
			return nil
		}
		return DialPlan.getSwiftObject(cObject: cPointer!)
	}
	///	Find best match for given CCC. 
	/// - Returns: Return matching dial plan, or a generic one if none found 
	static public func byCccAsInt(ccc:Int) -> DialPlan?
	{
		let cPointer = linphone_dial_plan_by_ccc_as_int(CInt(ccc))
		if (cPointer == nil) {
			return nil
		}
		return DialPlan.getSwiftObject(cObject: cPointer!)
	}

	/// - Returns: A list of `DialPlan` objects. LinphoneDialPlan  of all known dial
	/// plans 
	static public var getAllList: [DialPlan]
	{
			var swiftList = [DialPlan]()
			var cList = linphone_dial_plan_get_all_list()
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(DialPlan.getSwiftObject(cObject: data))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}
	///	Function to get call country code from an e164 number, ex: +33952650121 will
	///	return 33. 
	/// - Parameter e164: phone number 
	/// 
	/// 
	/// - Returns: call country code or -1 if not found 
	static public func lookupCccFromE164(e164:String) -> Int
	{
		return Int(linphone_dial_plan_lookup_ccc_from_e164(e164))
	}
	///	Function to get call country code from ISO 3166-1 alpha-2 code, ex: FR returns
	///	33. 
	/// - Parameter iso: country code alpha2 
	/// 
	/// 
	/// - Returns: call country code or -1 if not found 
	static public func lookupCccFromIso(iso:String) -> Int
	{
		return Int(linphone_dial_plan_lookup_ccc_from_iso(iso))
	}

	/// Returns the country name of the dialplan. 
	/// - Returns: the country name 
	public var country: String
	{
			return charArrayToString(charPointer: linphone_dial_plan_get_country(cPtr))
	}

	/// Returns the country calling code of the dialplan. 
	/// - Returns: the country calling code 
	public var countryCallingCode: String
	{
			return charArrayToString(charPointer: linphone_dial_plan_get_country_calling_code(cPtr))
	}

	/// Returns the international call prefix of the dialplan. 
	/// - Returns: the international call prefix 
	public var internationalCallPrefix: String
	{
			return charArrayToString(charPointer: linphone_dial_plan_get_international_call_prefix(cPtr))
	}

	/// Return if given plan is generic. 
	public var isGeneric: Bool
	{
			return linphone_dial_plan_is_generic(cPtr) != 0
	}

	/// Returns the iso country code of the dialplan. 
	/// - Returns: the iso country code 
	public var isoCountryCode: String
	{
			return charArrayToString(charPointer: linphone_dial_plan_get_iso_country_code(cPtr))
	}

	/// Returns the national number length of the dialplan. 
	/// - Returns: the national number length 
	public var nationalNumberLength: Int
	{
			return Int(linphone_dial_plan_get_national_number_length(cPtr))
	}
}

/// Object representing full details about a signaling error or status. 
/// All `ErrorInfo` object returned by the liblinphone API are readonly and
/// transcients. For safety they must be used immediately after obtaining them. Any
/// other function call to the liblinphone may change their content or invalidate
/// the pointer. 
public class ErrorInfo : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> ErrorInfo {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ErrorInfo>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ErrorInfo(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Get textual phrase from the error info. 
	/// This is the text that is provided by the peer in the protocol (SIP). 
	/// 
	/// - Returns: The error phrase 
	public var phrase: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_error_info_get_phrase(cPtr))
		}
		set
		{
			linphone_error_info_set_phrase(cPtr, newValue)
		}
	}

	/// Get protocol from the error info. 
	/// - Returns: The protocol 
	public var proto: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_error_info_get_protocol(cPtr))
		}
		set
		{
			linphone_error_info_set_protocol(cPtr, newValue)
		}
	}

	/// Get the status code from the low level protocol (ex a SIP status code). 
	/// - Returns: The status code 
	public var protocolCode: Int
	{
		get
		{
			return Int(linphone_error_info_get_protocol_code(cPtr))
		}
		set
		{
			linphone_error_info_set_protocol_code(cPtr, CInt(newValue))
		}
	}

	/// Get reason code from the error info. 
	/// - Returns: A LinphoneReason 
	public var reason: Reason
	{
		get
		{
			return Reason(rawValue: Int(linphone_error_info_get_reason(cPtr).rawValue))!
		}
		set
		{
			linphone_error_info_set_reason(cPtr, LinphoneReason(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get Retry-After delay second from the error info. 
	/// - Returns: The Retry-After delay second 
	public var retryAfter: Int
	{
		get
		{
			return Int(linphone_error_info_get_retry_after(cPtr))
		}
		set
		{
			linphone_error_info_set_retry_after(cPtr, CInt(newValue))
		}
	}

	/// Get pointer to chained `ErrorInfo` set in sub_ei. 
	/// It corresponds to a Reason header in a received SIP response. 
	/// 
	/// - Returns: `ErrorInfo` pointer defined in the ei object. 
	public var subErrorInfo: ErrorInfo?
	{
		get
		{
			let cPointer = linphone_error_info_get_sub_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ErrorInfo.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_error_info_set_sub_error_info(cPtr, newValue?.cPtr)
		}
	}

	/// Provides additional information regarding the failure. 
	/// With SIP protocol, the content of "Warning" headers are returned. 
	/// 
	/// - Returns: More details about the failure 
	public var warnings: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_error_info_get_warnings(cPtr))
		}
		set
		{
			linphone_error_info_set_warnings(cPtr, newValue)
		}
	}
	///	Assign information to a `ErrorInfo` object. 
	/// - Parameter proto: protocol name 
	/// - Parameter reason: reason from LinphoneReason enum 
	/// - Parameter code: protocol code 
	/// - Parameter statusString: description of the reason 
	/// - Parameter warning: warning message 
	/// 
	public func set(proto:String, reason:Reason, code:Int, statusString:String, warning:String) 
	{
		linphone_error_info_set(cPtr, proto, LinphoneReason(rawValue: CUnsignedInt(reason.rawValue)), CInt(code), statusString, warning)
	}
}

/// Object representing an event state, which is subcribed or published. 
/// - See also: {@link Core#publish} 
/// 
/// - See also: {@link Core#subscribe} 
public class Event : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Event {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Event>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Event(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	public func getDelegate() -> EventDelegate?
	{
		let cObject = linphone_event_get_callbacks(cPtr)
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<EventDelegate>.fromOpaque(result!).takeUnretainedValue()
			}
		return nil
	}
	public func addDelegate(delegate: EventDelegate)
	{
		linphone_event_add_callbacks(cPtr, delegate.cPtr)
	}
	public func removeDelegate(delegate: EventDelegate)
	{
		linphone_event_remove_callbacks(cPtr, delegate.cPtr)
	}

	/// Returns back pointer to the `Core` that created this `Event`. 
	public var core: Core?
	{
			let cPointer = linphone_event_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Core.getSwiftObject(cObject:cPointer!)
	}

	/// Get the current LinphoneEventCbs object associated with a LinphoneEvent. 
	/// - Returns: The current LinphoneEventCbs object associated with the
	/// LinphoneEvent. 
	public var currentCallbacks: EventDelegate?
	{
			let cObject = linphone_event_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<EventDelegate>.fromOpaque(result!).takeUnretainedValue()
				}
			return nil
	}

	/// Get full details about an error occured. 
	public var errorInfo: ErrorInfo?
	{
			let cPointer = linphone_event_get_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ErrorInfo.getSwiftObject(cObject:cPointer!)
	}

	/// Get the "from" address of the subscription. 
	public var from: Address?
	{
			let cPointer = linphone_event_get_from(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Get the name of the event as specified in the event package RFC. 
	public var name: String
	{
			return charArrayToString(charPointer: linphone_event_get_name(cPtr))
	}

	/// Get publish state. 
	/// If the event object was not created by a publish mechanism, LinphonePublishNone
	/// is returned. 
	public var publishState: PublishState
	{
			return PublishState(rawValue: Int(linphone_event_get_publish_state(cPtr).rawValue))!
	}

	/// Return reason code (in case of error state reached). 
	public var reason: Reason
	{
			return Reason(rawValue: Int(linphone_event_get_reason(cPtr).rawValue))!
	}

	/// Get the "contact" address of the subscription. 
	/// - Returns: The "contact" address of the subscription 
	public var remoteContact: Address?
	{
			let cPointer = linphone_event_get_remote_contact(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Get the resource address of the subscription or publish. 
	public var resource: Address?
	{
			let cPointer = linphone_event_get_resource(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Get subscription direction. 
	/// If the object wasn't created by a subscription mechanism,
	/// LinphoneSubscriptionInvalidDir is returned. 
	public var subscriptionDir: SubscriptionDir
	{
			return SubscriptionDir(rawValue: Int(linphone_event_get_subscription_dir(cPtr).rawValue))!
	}

	/// Get subscription state. 
	/// If the event object was not created by a subscription mechanism,
	/// LinphoneSubscriptionNone is returned. 
	public var subscriptionState: SubscriptionState
	{
			return SubscriptionState(rawValue: Int(linphone_event_get_subscription_state(cPtr).rawValue))!
	}

	/// Retrieve user pointer. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_event_get_user_data(cPtr)
		}
		set
		{
			linphone_event_set_user_data(cPtr, newValue)
		}
	}
	///	Accept an incoming subcription. 
	public func acceptSubscription() throws 
	{
		let exception_result = linphone_event_accept_subscription(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "acceptSubscription returned value \(exception_result)")
		}
	}
	///	Add a custom header to an outgoing susbscription or publish. 
	/// - Parameter name: header's name 
	/// - Parameter value: the header's value. 
	/// 
	public func addCustomHeader(name:String, value:String) 
	{
		linphone_event_add_custom_header(cPtr, name, value)
	}
	///	Deny an incoming subscription with given reason. 
	public func denySubscription(reason:Reason) throws 
	{
		let exception_result = linphone_event_deny_subscription(cPtr, LinphoneReason(rawValue: CUnsignedInt(reason.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "denySubscription returned value \(exception_result)")
		}
	}
	///	Obtain the value of a given header for an incoming subscription. 
	/// - Parameter name: header's name 
	/// 
	/// 
	/// - Returns: the header's value or nil if such header doesn't exist. 
	public func getCustomHeader(name:String) -> String
	{
		return charArrayToString(charPointer: linphone_event_get_custom_header(cPtr, name))
	}
	///	Send a notification. 
	/// - Parameter body: an optional body containing the actual notification data. 
	/// 
	/// 
	/// - Returns: 0 if successful, -1 otherwise. 
	public func notify(body:Content) throws 
	{
		let exception_result = linphone_event_notify(cPtr, body.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "notify returned value \(exception_result)")
		}
	}
	///	Prevent an event from refreshing its publish. 
	/// This is useful to let registrations to expire naturally (or) when the
	/// application wants to keep control on when refreshes are sent. The refreshing
	/// operations can be resumed with {@link ProxyConfig#refreshRegister}. 
	public func pausePublish() 
	{
		linphone_event_pause_publish(cPtr)
	}
	///	Refresh an outgoing publish keeping the same body. 
	/// - Returns: 0 if successful, -1 otherwise. 
	public func refreshPublish() throws 
	{
		let exception_result = linphone_event_refresh_publish(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "refreshPublish returned value \(exception_result)")
		}
	}
	///	Refresh an outgoing subscription keeping the same body. 
	/// - Returns: 0 if successful, -1 otherwise. 
	public func refreshSubscribe() throws 
	{
		let exception_result = linphone_event_refresh_subscribe(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "refreshSubscribe returned value \(exception_result)")
		}
	}
	///	Send a publish created by {@link Core#createPublish}. 
	/// - Parameter body: the new data to be published 
	/// 
	public func sendPublish(body:Content) throws 
	{
		let exception_result = linphone_event_send_publish(cPtr, body.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "sendPublish returned value \(exception_result)")
		}
	}
	///	Send a subscription previously created by {@link Core#createSubscribe}. 
	/// - Parameter body: optional content to attach with the subscription. 
	/// 
	/// 
	/// - Returns: 0 if successful, -1 otherwise. 
	public func sendSubscribe(body:Content) throws 
	{
		let exception_result = linphone_event_send_subscribe(cPtr, body.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "sendSubscribe returned value \(exception_result)")
		}
	}
	///	Terminate an incoming or outgoing subscription that was previously acccepted,
	///	or a previous publication. 
	/// The `Event` shall not be used anymore after this operation, unless the
	/// application explicitely took a reference on the object with linphone_event_ref. 
	public func terminate() 
	{
		linphone_event_terminate(cPtr)
	}
	///	Update (refresh) a publish. 
	/// - Parameter body: the new data to be published 
	/// 
	public func updatePublish(body:Content) throws 
	{
		let exception_result = linphone_event_update_publish(cPtr, body.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "updatePublish returned value \(exception_result)")
		}
	}
	///	Update (refresh) an outgoing subscription, changing the body. 
	/// - Parameter body: an optional body to include in the subscription update, may
	/// be nil.    
	/// 
	public func updateSubscribe(body:Content?) throws 
	{
		let exception_result = linphone_event_update_subscribe(cPtr, body?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "updateSubscribe returned value \(exception_result)")
		}
	}
}

/// Base object of events. 
public class EventLog : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> EventLog {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<EventLog>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = EventLog(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Returns the call of a conference call event. 
	/// - Returns: The conference call. 
	public var call: Call?
	{
			let cPointer = linphone_event_log_get_call(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Call.getSwiftObject(cObject:cPointer!)
	}

	/// Returns the chat message of a conference chat message event. 
	/// - Returns: The conference chat message. 
	public var chatMessage: ChatMessage?
	{
			let cPointer = linphone_event_log_get_chat_message(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ChatMessage.getSwiftObject(cObject:cPointer!)
	}

	/// Returns the creation time of a event log. 
	/// - Returns: The event creation time 
	public var creationTime: time_t
	{
			return linphone_event_log_get_creation_time(cPtr)
	}

	/// Returns the device address of a conference participant device event. 
	/// - Returns: The conference device address. 
	public var deviceAddress: Address?
	{
			let cPointer = linphone_event_log_get_device_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Returns the ephemeral message lifetime of a conference ephemeral message event. 
	/// Ephemeral lifetime means the time before an ephemeral message which has been
	/// viewed gets deleted. 
	/// 
	/// - Returns: The ephemeral message lifetime. 
	public var ephemeralMessageLifetime: Int
	{
			return Int(linphone_event_log_get_ephemeral_message_lifetime(cPtr))
	}

	/// Returns the local address of a conference event. 
	/// - Returns: The local address. 
	public var localAddress: Address?
	{
			let cPointer = linphone_event_log_get_local_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Returns the notify id of a conference notified event. 
	/// - Returns: The conference notify id. 
	public var notifyId: UInt
	{
			return UInt(linphone_event_log_get_notify_id(cPtr))
	}

	/// Returns the participant address of a conference participant event. 
	/// - Returns: The conference participant address. 
	public var participantAddress: Address?
	{
			let cPointer = linphone_event_log_get_participant_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Returns the peer address of a conference event. 
	/// - Returns: The peer address. 
	public var peerAddress: Address?
	{
			let cPointer = linphone_event_log_get_peer_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Returns the faulty device address of a conference security event. 
	/// - Returns: The address of the faulty device. 
	public var securityEventFaultyDeviceAddress: Address?
	{
			let cPointer = linphone_event_log_get_security_event_faulty_device_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Returns the type of security event. 
	/// - Returns: The security event type. 
	public var securityEventType: SecurityEventType
	{
			return SecurityEventType(rawValue: Int(linphone_event_log_get_security_event_type(cPtr).rawValue))!
	}

	/// Returns the subject of a conference subject event. 
	/// - Returns: The conference subject. 
	public var subject: String
	{
			return charArrayToString(charPointer: linphone_event_log_get_subject(cPtr))
	}

	/// Returns the type of a event log. 
	/// - Returns: The event type 
	public var type: EventLogType
	{
			return EventLogType(rawValue: Int(linphone_event_log_get_type(cPtr).rawValue))!
	}
	///	Delete event log from database. 
	public func deleteFromDatabase() 
	{
		linphone_event_log_delete_from_database(cPtr)
	}
}

/// `Factory` is a singleton object devoted to the creation of all the object of
/// Liblinphone that cannot be created by `Core` itself. 
public class Factory : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Factory {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Factory>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Factory(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///	Clean the factory. 
	/// This function is generally useless as the factory is unique per process,
	/// however calling this function at the end avoid getting reports from belle-sip
	/// leak detector about memory leaked in {@link Factory#get}. 
	static public func clean() 
	{
		linphone_factory_clean()
	}

	/// Create the `Factory` if that has not been done and return a pointer on it. 
	/// - Returns: A pointer on the `Factory` 
	static public var Instance: Factory
	{
			return Factory.getSwiftObject(cObject:linphone_factory_get())
	}

	/// Get the directory where the data resources are located. 
	/// - Returns: The path to the directory where the data resources are located 
	public var dataResourcesDir: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_factory_get_data_resources_dir(cPtr))
		}
		set
		{
			linphone_factory_set_data_resources_dir(cPtr, newValue)
		}
	}

	/// Returns a bctbx_list_t of all DialPlans. 
	/// - Returns: A list of `DialPlan` objects. LinphoneDialPlan  a list of DialPlan 
	public var dialPlans: [DialPlan]
	{
			var swiftList = [DialPlan]()
			var cList = linphone_factory_get_dial_plans(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(DialPlan.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Get the directory where the image resources are located. 
	/// - Returns: The path to the directory where the image resources are located 
	public var imageResourcesDir: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_factory_get_image_resources_dir(cPtr))
		}
		set
		{
			linphone_factory_set_image_resources_dir(cPtr, newValue)
		}
	}

	/// Indicates if the storage in database is available. 
	/// - Returns:  if the database storage is available, true otherwise 
	public var isDatabaseStorageAvailable: Bool
	{
			return linphone_factory_is_database_storage_available(cPtr) != 0
	}

	/// Indicates if IMDN are available. 
	/// - Returns:  if IDMN are available 
	public var isImdnAvailable: Bool
	{
			return linphone_factory_is_imdn_available(cPtr) != 0
	}

	/// Sets the log collection path. 
	/// - Parameter path: the path of the logs 
	/// 
	public var logCollectionPath: String = ""
	{
		willSet
		{
			linphone_factory_set_log_collection_path(cPtr, newValue)
		}
	}

	/// Get the directory where the mediastreamer2 plugins are located. 
	/// - Returns: The path to the directory where the mediastreamer2 plugins are
	/// located, or nil if it has not been set 
	public var mspluginsDir: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_factory_get_msplugins_dir(cPtr))
		}
		set
		{
			linphone_factory_set_msplugins_dir(cPtr, newValue)
		}
	}

	/// Get the directory where the ring resources are located. 
	/// - Returns: The path to the directory where the ring resources are located 
	public var ringResourcesDir: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_factory_get_ring_resources_dir(cPtr))
		}
		set
		{
			linphone_factory_set_ring_resources_dir(cPtr, newValue)
		}
	}

	/// Get the directory where the sound resources are located. 
	/// - Returns: The path to the directory where the sound resources are located 
	public var soundResourcesDir: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_factory_get_sound_resources_dir(cPtr))
		}
		set
		{
			linphone_factory_set_sound_resources_dir(cPtr, newValue)
		}
	}

	/// Get the list of standard video definitions supported by Linphone. 
	/// - Returns: A list of `VideoDefinition` objects. LinphoneVideoDefinition  
	public var supportedVideoDefinitions: [VideoDefinition]
	{
			var swiftList = [VideoDefinition]()
			var cList = linphone_factory_get_supported_video_definitions(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(VideoDefinition.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Get the top directory where the resources are located. 
	/// - Returns: The path to the top directory where the resources are located 
	public var topResourcesDir: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_factory_get_top_resources_dir(cPtr))
		}
		set
		{
			linphone_factory_set_top_resources_dir(cPtr, newValue)
		}
	}

	/// Gets the user data in the `Factory` object. 
	/// - Returns: the user data 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_factory_get_user_data(cPtr)
		}
		set
		{
			linphone_factory_set_user_data(cPtr, newValue)
		}
	}
	///	Parse a string holding a SIP URI and create the according `Address` object. 
	/// - Parameter addr: A string holding the SIP URI to parse. 
	/// 
	/// 
	/// - Returns: A new `Address`. 
	public func createAddress(addr:String) throws -> Address
	{
		let cPointer = linphone_factory_create_address(cPtr, addr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Address value")
		}
		return Address.getSwiftObject(cObject: cPointer!)
	}
	///	Creates a `AuthInfo` object. 
	/// The object can be created empty, that is with all arguments set to nil.
	/// Username, userid, password, realm and domain can be set later using specific
	/// methods. At the end, username and passwd (or ha1) are required. 
	/// 
	/// - Parameter username: The username that needs to be authenticated 
	/// - Parameter userid: The userid used for authenticating (use nil if you don't
	/// know what it is) 
	/// - Parameter passwd: The password in clear text 
	/// - Parameter ha1: The ha1-encrypted password if password is not given in clear
	/// text. 
	/// - Parameter realm: The authentication domain (which can be larger than the sip
	/// domain. Unfortunately many SIP servers don't use this parameter. 
	/// - Parameter domain: The SIP domain for which this authentication information is
	/// valid, if it has to be restricted for a single SIP domain. 
	/// - Parameter algorithm: The algorithm for encrypting password. 
	/// 
	/// 
	/// - Returns: A `AuthInfo` object. linphone_auth_info_destroy() must be used to
	/// destroy it when no longer needed. The `Core` makes a copy of `AuthInfo` passed
	/// through {@link Core#addAuthInfo}. 
	public func createAuthInfo(username:String, userid:String, passwd:String, ha1:String, realm:String, domain:String, algorithm:String) throws -> AuthInfo
	{
		let cPointer = linphone_factory_create_auth_info_2(cPtr, username, userid, passwd, ha1, realm, domain, algorithm)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null AuthInfo value")
		}
		return AuthInfo.getSwiftObject(cObject: cPointer!)
	}
	///	Creates a `AuthInfo` object. 
	/// The object can be created empty, that is with all arguments set to nil.
	/// Username, userid, password, realm and domain can be set later using specific
	/// methods. At the end, username and passwd (or ha1) are required. 
	/// 
	/// - Parameter username: The username that needs to be authenticated 
	/// - Parameter userid: The userid used for authenticating (use nil if you don't
	/// know what it is) 
	/// - Parameter passwd: The password in clear text 
	/// - Parameter ha1: The ha1-encrypted password if password is not given in clear
	/// text. 
	/// - Parameter realm: The authentication domain (which can be larger than the sip
	/// domain. Unfortunately many SIP servers don't use this parameter. 
	/// - Parameter domain: The SIP domain for which this authentication information is
	/// valid, if it has to be restricted for a single SIP domain. 
	/// 
	/// 
	/// - Returns: A `AuthInfo` object. linphone_auth_info_destroy() must be used to
	/// destroy it when no longer needed. The `Core` makes a copy of `AuthInfo` passed
	/// through {@link Core#addAuthInfo}. 
	public func createAuthInfo(username:String, userid:String, passwd:String, ha1:String, realm:String, domain:String) throws -> AuthInfo
	{
		let cPointer = linphone_factory_create_auth_info(cPtr, username, userid, passwd, ha1, realm, domain)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null AuthInfo value")
		}
		return AuthInfo.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an object `Buffer`. 
	/// - Returns: a `Buffer` 
	public func createBuffer() throws -> Buffer
	{
		let cPointer = linphone_factory_create_buffer(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Buffer value")
		}
		return Buffer.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an object `Buffer`. 
	/// - Parameter data: the data to set in the buffer 
	/// - Parameter size: the size of the data 
	/// 
	/// 
	/// - Returns: a `Buffer` 
	public func createBufferFromData(data:UnsafePointer<UInt8>, size:Int) throws -> Buffer
	{
		let cPointer = linphone_factory_create_buffer_from_data(cPtr, data, size)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Buffer value")
		}
		return Buffer.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an object `Buffer`. 
	/// - Parameter data: the data to set in the buffer 
	/// 
	/// 
	/// - Returns: a `Buffer` 
	public func createBufferFromString(data:String) throws -> Buffer
	{
		let cPointer = linphone_factory_create_buffer_from_string(cPtr, data)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Buffer value")
		}
		return Buffer.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an object `Config`. 
	/// - Parameter path: the path of the config 
	/// 
	/// 
	/// - Returns: a `Config` 
	public func createConfig(path:String) throws -> Config
	{
		let cPointer = linphone_factory_create_config(cPtr, path)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Config value")
		}
		return Config.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an object `Config`. 
	/// - Parameter data: the config data 
	/// 
	/// 
	/// - Returns: a `Config` 
	public func createConfigFromString(data:String) throws -> Config
	{
		let cPointer = linphone_factory_create_config_from_string(cPtr, data)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Config value")
		}
		return Config.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an object `Config`. 
	/// - Parameter path: the path of the config 
	/// - Parameter path: the path of the factory 
	/// 
	/// 
	/// - Returns: a `Config` 
	public func createConfigWithFactory(path:String, factoryPath:String) throws -> Config
	{
		let cPointer = linphone_factory_create_config_with_factory(cPtr, path, factoryPath)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Config value")
		}
		return Config.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an object `Content`. 
	/// - Returns: a `Content` 
	public func createContent() throws -> Content
	{
		let cPointer = linphone_factory_create_content(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Content value")
		}
		return Content.getSwiftObject(cObject: cPointer!)
	}
	///	Instantiate a `Core` object. 
	/// The `Core` object is the primary handle for doing all phone actions. It should
	/// be unique within your application. The `Core` object is not started
	/// automatically, you need to call {@link Core#start} to that effect. The returned
	/// `Core` will be in LinphoneGlobalState Ready. Core ressources can be released
	/// using {@link Core#stop} which is strongly encouraged on garbage collected
	/// languages. 
	/// 
	/// - Parameter configPath: A path to a config file. If it does not exists it will
	/// be created. The config file is used to store all settings, proxies... so that
	/// all these settings become persistent over the life of the `Core` object. It is
	/// allowed to set a nil config file. In that case `Core` will not store any
	/// settings. 
	/// - Parameter factoryConfigPath: A path to a read-only config file that can be
	/// used to store hard-coded preferences such as proxy settings or internal
	/// preferences. The settings in this factory file always override the ones in the
	/// normal config file. It is optional, use nil if unneeded. 
	/// - Parameter systemContext: A pointer to a system object required by the core to
	/// operate. Currently it is required to pass an android Context on android, pass
	/// nil on other platforms. 
	/// 
	/// 
	/// - See also: linphone_core_new_with_config_3 
	public func createCore(configPath:String, factoryConfigPath:String, systemContext:UnsafeMutableRawPointer?) throws -> Core
	{
		let cPointer = linphone_factory_create_core_3(cPtr, configPath, factoryConfigPath, systemContext)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Core value")
		}
		return Core.getSwiftObject(cObject: cPointer!)
	}
	///	Instantiate a `Core` object with a given LinphoneConfig. 
	/// The `Core` object is the primary handle for doing all phone actions. It should
	/// be unique within your application. The `Core` object is not started
	/// automatically, you need to call {@link Core#start} to that effect. The returned
	/// `Core` will be in LinphoneGlobalState Ready. Core ressources can be released
	/// using {@link Core#stop} which is strongly encouraged on garbage collected
	/// languages. 
	/// 
	/// - Parameter config: A `Config` object holding the configuration for the `Core`
	/// to be instantiated. 
	/// - Parameter systemContext: A pointer to a system object required by the core to
	/// operate. Currently it is required to pass an android Context on android, pass
	/// nil on other platforms. 
	/// 
	/// 
	/// - See also: linphone_factory_create_core_3 
	public func createCoreWithConfig(config:Config, systemContext:UnsafeMutableRawPointer?) throws -> Core
	{
		let cPointer = linphone_factory_create_core_with_config_3(cPtr, config.cPtr, systemContext)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Core value")
		}
		return Core.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an object LinphoneErrorInfo. 
	/// - Returns: `ErrorInfo` object. 
	public func createErrorInfo() throws -> ErrorInfo
	{
		let cPointer = linphone_factory_create_error_info(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ErrorInfo value")
		}
		return ErrorInfo.getSwiftObject(cObject: cPointer!)
	}
	///	Create a #LinphoneParticipantDeviceIdentity object. 
	/// - Parameter address: `Address` object. 
	/// - Parameter name: the name given to the device. 
	/// 
	/// 
	/// - Returns: A new #LinphoneParticipantDeviceIdentity. 
	public func createParticipantDeviceIdentity(address:Address, name:String) throws -> ParticipantDeviceIdentity
	{
		let cPointer = linphone_factory_create_participant_device_identity(cPtr, address.cPtr, name)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ParticipantDeviceIdentity value")
		}
		return ParticipantDeviceIdentity.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an object LinphoneRange. 
	/// - Returns: `Range` object. 
	public func createRange() throws -> Range
	{
		let cPointer = linphone_factory_create_range(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Range value")
		}
		return Range.getSwiftObject(cObject: cPointer!)
	}
	///	Instantiate a shared `Core` object. 
	/// The shared `Core` allow you to create several `Core` with the same config. Two
	/// `Core` can't run at the same time.
	/// 
	/// A shared `Core` can be a "Main Core" or an "Executor Core". A "Main Core"
	/// automatically stops a running "Executor Core" when calling {@link Core#start}
	/// An "Executor Core" can't start unless no other `Core` is started. It can be
	/// stopped by a "Main Core" and switch to LinphoneGlobalState Off at any time.
	/// 
	/// Shared Executor Core are used in iOS UNNotificationServiceExtension to receive
	/// new messages from push notifications. When the application is in background,
	/// its Shared Main Core is stopped.
	/// 
	/// The `Core` object is not started automatically, you need to call {@link
	/// Core#start} to that effect. The returned `Core` will be in LinphoneGlobalState
	/// Ready. Core ressources can be released using {@link Core#stop} which is
	/// strongly encouraged on garbage collected languages. 
	/// 
	/// - Parameter configFilename: The name of the config file. If it does not exists
	/// it will be created. Its path is computed using the app_group_id. The config
	/// file is used to store all settings, proxies... so that all these settings
	/// become persistent over the life of the `Core` object. It is allowed to set a
	/// nil config file. In that case `Core` will not store any settings. 
	/// - Parameter factoryConfigPath: A path to a read-only config file that can be
	/// used to store hard-coded preferences such as proxy settings or internal
	/// preferences. The settings in this factory file always override the ones in the
	/// normal config file. It is optional, use nil if unneeded. 
	/// - Parameter systemContext: A pointer to a system object required by the core to
	/// operate. Currently it is required to pass an android Context on android, pass
	/// nil on other platforms. 
	/// - Parameter appGroupId: Name of iOS App Group that lead to the file system that
	/// is shared between an app and its app extensions. 
	/// - Parameter mainCore: Indicate if we want to create a "Main Core" or an
	/// "Executor Core". 
	/// 
	/// 
	/// - See also: linphone_factory_create_shared_core_with_config 
	public func createSharedCore(configFilename:String, factoryConfigPath:String, systemContext:UnsafeMutableRawPointer?, appGroupId:String, mainCore:Bool) throws -> Core
	{
		let cPointer = linphone_factory_create_shared_core(cPtr, configFilename, factoryConfigPath, systemContext, appGroupId, mainCore==true ? 1:0)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Core value")
		}
		return Core.getSwiftObject(cObject: cPointer!)
	}
	///	Instantiate a shared `Core` object. 
	/// The shared `Core` allow you to create several `Core` with the same config. Two
	/// `Core` can't run at the same time.
	/// 
	/// A shared `Core` can be a "Main Core" or an "Executor Core". A "Main Core"
	/// automatically stops a running "Executor Core" when calling {@link Core#start}
	/// An "Executor Core" can't start unless no other `Core` is started. It can be
	/// stopped by a "Main Core" and switch to LinphoneGlobalState Off at any time.
	/// 
	/// Shared Executor Core are used in iOS UNNotificationServiceExtension to receive
	/// new messages from push notifications. When the application is in background,
	/// its Shared Main Core is stopped.
	/// 
	/// The `Core` object is not started automatically, you need to call {@link
	/// Core#start} to that effect. The returned `Core` will be in LinphoneGlobalState
	/// Ready. Core ressources can be released using {@link Core#stop} which is
	/// strongly encouraged on garbage collected languages. 
	/// 
	/// - Parameter config: A `Config` object holding the configuration for the `Core`
	/// to be instantiated. 
	/// - Parameter systemContext: A pointer to a system object required by the core to
	/// operate. Currently it is required to pass an android Context on android, pass
	/// nil on other platforms. 
	/// - Parameter appGroupId: Name of iOS App Group that lead to the file system that
	/// is shared between an app and its app extensions. 
	/// - Parameter mainCore: Indicate if we want to create a "Main Core" or an
	/// "Executor Core". 
	/// 
	/// 
	/// - See also: linphone_factory_create_shared_core 
	public func createSharedCoreWithConfig(config:Config, systemContext:UnsafeMutableRawPointer?, appGroupId:String, mainCore:Bool) throws -> Core
	{
		let cPointer = linphone_factory_create_shared_core_with_config(cPtr, config.cPtr, systemContext, appGroupId, mainCore==true ? 1:0)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Core value")
		}
		return Core.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an object LinphoneTransports. 
	/// - Returns: `Transports` object. 
	public func createTransports() throws -> Transports
	{
		let cPointer = linphone_factory_create_transports(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Transports value")
		}
		return Transports.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an object `TunnelConfig`. 
	/// - Returns: a `TunnelConfig` 
	public func createTunnelConfig() throws -> TunnelConfig
	{
		let cPointer = linphone_factory_create_tunnel_config(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null TunnelConfig value")
		}
		return TunnelConfig.getSwiftObject(cObject: cPointer!)
	}
	///	Create an empty `Vcard`. 
	/// - Returns: a new `Vcard`. 
	public func createVcard() throws -> Vcard
	{
		let cPointer = linphone_factory_create_vcard(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Vcard value")
		}
		return Vcard.getSwiftObject(cObject: cPointer!)
	}
	///	Creates an object LinphoneVideoActivationPolicy. 
	/// - Returns: `VideoActivationPolicy` object. 
	public func createVideoActivationPolicy() throws -> VideoActivationPolicy
	{
		let cPointer = linphone_factory_create_video_activation_policy(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null VideoActivationPolicy value")
		}
		return VideoActivationPolicy.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `VideoDefinition` from a given width and height. 
	/// - Parameter width: The width of the created video definition 
	/// - Parameter height: The height of the created video definition 
	/// 
	/// 
	/// - Returns: A new `VideoDefinition` object 
	public func createVideoDefinition(width:UInt, height:UInt) throws -> VideoDefinition
	{
		let cPointer = linphone_factory_create_video_definition(cPtr, CUnsignedInt(width), CUnsignedInt(height))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null VideoDefinition value")
		}
		return VideoDefinition.getSwiftObject(cObject: cPointer!)
	}
	///	Create a `VideoDefinition` from a given standard definition name. 
	/// - Parameter name: The standard definition name of the video definition to
	/// create 
	/// 
	/// 
	/// - Returns: A new `VideoDefinition` object 
	public func createVideoDefinitionFromName(name:String) throws -> VideoDefinition
	{
		let cPointer = linphone_factory_create_video_definition_from_name(cPtr, name)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null VideoDefinition value")
		}
		return VideoDefinition.getSwiftObject(cObject: cPointer!)
	}
	///	Enables or disables log collection. 
	/// - Parameter state: the policy for log collection 
	/// 
	public func enableLogCollection(state:LogCollectionState) 
	{
		linphone_factory_enable_log_collection(cPtr, LinphoneLogCollectionState(rawValue: CUnsignedInt(state.rawValue)))
	}
	///	Get the config path. 
	/// - Parameter context: used to compute path. can be nil. JavaPlatformHelper on
	/// Android and char *appGroupId on iOS with shared core. 
	/// 
	/// 
	/// - Returns: The config path 
	public func getConfigDir(context:UnsafeMutableRawPointer?) -> String
	{
		return charArrayToString(charPointer: linphone_factory_get_config_dir(cPtr, context))
	}
	///	Get the data path. 
	/// - Parameter context: used to compute path. can be nil. JavaPlatformHelper on
	/// Android and char *appGroupId on iOS with shared core. 
	/// 
	/// 
	/// - Returns: The data path 
	public func getDataDir(context:UnsafeMutableRawPointer?) -> String
	{
		return charArrayToString(charPointer: linphone_factory_get_data_dir(cPtr, context))
	}
	///	Get the download path. 
	/// - Parameter context: used to compute path. can be nil. JavaPlatformHelper on
	/// Android and char *appGroupId on iOS with shared core. 
	/// 
	/// 
	/// - Returns: The download path 
	public func getDownloadDir(context:UnsafeMutableRawPointer?) -> String
	{
		return charArrayToString(charPointer: linphone_factory_get_download_dir(cPtr, context))
	}
	///	Indicates if the given LinphoneChatRoomBackend is available. 
	/// - Parameter chatroomBackend: the LinphoneChatRoomBackend 
	/// 
	/// 
	/// - Returns:  if the chatroom backend is available, true otherwise 
	public func isChatroomBackendAvailable(chatroomBackend:ChatRoomBackend) -> Bool
	{
		return linphone_factory_is_chatroom_backend_available(cPtr, LinphoneChatRoomBackend(rawValue: CUnsignedInt(chatroomBackend.rawValue))) != 0
	}
}

/// Represents a buddy, all presence actions like subscription and status change
/// notification are performed on this object. 
public class Friend : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Friend {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Friend>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Friend(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///	Contructor same as linphone_friend_new + {@link Friend#setAddress} 
	/// - Parameter vcard: a vCard object 
	/// 
	/// 
	/// - Returns: a new `Friend` with vCard initialized  
	static public func newFromVcard(vcard:Vcard) -> Friend?
	{
		let cPointer = linphone_friend_new_from_vcard(vcard.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return Friend.getSwiftObject(cObject: cPointer!)
	}

	/// Get address of this friend. 
	/// - Note: the `Address` object returned is hold by the LinphoneFriend, however
	/// calling several time this function may return different objects. 
	/// 
	/// - Returns: `Address` 
	public var address: Address?
	{
			let cPointer = linphone_friend_get_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	public func setAddress(newValue: Address) throws
	{
		let exception_result = linphone_friend_set_address(cPtr, newValue.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns a list of `Address` for this friend. 
	/// - Returns: A list of `Address` objects. LinphoneAddress  
	public var addresses: [Address]
	{
			var swiftList = [Address]()
			var cList = linphone_friend_get_addresses(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Address.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Returns the capabilities associated to this friend. 
	/// - Returns: an int representing the capabilities of the friend 
	public var capabilities: Int
	{
			return Int(linphone_friend_get_capabilities(cPtr))
	}

	/// Get the consolidated presence of a friend. 
	/// - Returns: The consolidated presence of the friend 
	public var consolidatedPresence: ConsolidatedPresence
	{
			return ConsolidatedPresence(rawValue: Int(linphone_friend_get_consolidated_presence(cPtr).rawValue))!
	}

	/// Returns the `Core` object managing this friend, if any. 
	public var core: Core?
	{
			let cPointer = linphone_friend_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Core.getSwiftObject(cObject:cPointer!)
	}

	/// get current subscription policy for this `Friend` 
	/// - Returns: LinphoneSubscribePolicy 
	public var incSubscribePolicy: SubscribePolicy
	{
			return SubscribePolicy(rawValue: Int(linphone_friend_get_inc_subscribe_policy(cPtr).rawValue))!
	}

	public func setIncsubscribepolicy(newValue: SubscribePolicy) throws
	{
		let exception_result = linphone_friend_set_inc_subscribe_policy(cPtr, LinphoneSubscribePolicy(rawValue: CUnsignedInt(newValue.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Tells whether we already received presence information for a friend. 
	/// - Returns:  if presence information has been received for the friend, true
	/// otherwise. 
	public var isPresenceReceived: Bool
	{
			return linphone_friend_is_presence_received(cPtr) != 0
	}

	/// Get the display name for this friend. 
	/// - Returns: The display name of this friend 
	public var name: String
	{
			return charArrayToString(charPointer: linphone_friend_get_name(cPtr))
	}

	public func setName(newValue: String) throws
	{
		let exception_result = linphone_friend_set_name(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns a list of phone numbers for this friend. 
	/// - Returns: A list of const char * objects. const char *  
	public var phoneNumbers: [String]
	{
			var swiftList = [String]()
			var cList = linphone_friend_get_phone_numbers(cPtr)
			while (cList != nil) {
				swiftList.append(String(cString: unsafeBitCast(cList!.pointee.data, to: UnsafePointer<CChar>.self)))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList!.pointee.next)
			}
			return swiftList
	}

	/// Get the presence model of a friend. 
	/// - Returns: A `PresenceModel` object, or nil if the friend do not have presence
	/// information (in which case he is considered offline) 
	public var presenceModel: PresenceModel?
	{
		get
		{
			let cPointer = linphone_friend_get_presence_model(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return PresenceModel.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_friend_set_presence_model(cPtr, newValue?.cPtr)
		}
	}

	/// Get the reference key of a friend. 
	/// - Returns: The reference key of the friend. 
	public var refKey: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_friend_get_ref_key(cPtr))
		}
		set
		{
			linphone_friend_set_ref_key(cPtr, newValue)
		}
	}

	/// get subscription flag value 
	/// - Returns: returns true is subscription is activated for this friend 
	public var subscribesEnabled: Bool
	{
			return linphone_friend_subscribes_enabled(cPtr) != 0
	}

	public func setSubscribesenabled(newValue: Bool) throws
	{
		let exception_result = linphone_friend_enable_subscribes(cPtr, newValue==true ? 1:0)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get subscription state of a friend. 
	/// - Returns: LinphoneSubscriptionState 
	public var subscriptionState: SubscriptionState
	{
			return SubscriptionState(rawValue: Int(linphone_friend_get_subscription_state(cPtr).rawValue))!
	}

	/// Retrieve user data associated with friend. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_friend_get_user_data(cPtr)
		}
		set
		{
			linphone_friend_set_user_data(cPtr, newValue)
		}
	}

	/// Returns the vCard object associated to this friend, if any. 
	public var vcard: Vcard?
	{
		get
		{
			let cPointer = linphone_friend_get_vcard(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Vcard.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_friend_set_vcard(cPtr, newValue?.cPtr)
		}
	}
	///	Adds an address in this friend. 
	/// - Parameter addr: `Address` object 
	/// 
	public func addAddress(addr:Address) 
	{
		linphone_friend_add_address(cPtr, addr.cPtr)
	}
	///	Adds a phone number in this friend. 
	/// - Parameter phone: number to add 
	/// 
	public func addPhoneNumber(phone:String) 
	{
		linphone_friend_add_phone_number(cPtr, phone)
	}
	///	Creates a vCard object associated to this friend if there isn't one yet and if
	///	the full name is available, either by the parameter or the one in the friend's
	///	SIP URI. 
	/// - Parameter name: The full name of the friend or nil to use the one from the
	/// friend's SIP URI 
	/// 
	/// 
	/// - Returns: true if the vCard has been created, false if it wasn't possible (for
	/// exemple if name and the friend's SIP URI are null or if the friend's SIP URI
	/// doesn't have a display name), or if there is already one vcard 
	public func createVcard(name:String) throws -> Bool
	{
		return linphone_friend_create_vcard(cPtr, name) != 0
	}
	///	Commits modification made to the friend configuration. 
	public func done() 
	{
		linphone_friend_done(cPtr)
	}
	///	Starts editing a friend configuration. 
	/// Because friend configuration must be consistent, applications MUST call {@link
	/// Friend#edit} before doing any attempts to modify friend configuration (such as
	/// address  or subscription policy and so on). Once the modifications are done,
	/// then the application must call {@link Friend#done} to commit the changes. 
	public func edit() 
	{
		linphone_friend_edit(cPtr)
	}
	///	Returns the version of a friend's capbility. 
	/// - Parameter capability: LinphoneFriendCapability object 
	/// 
	/// 
	/// - Returns: the version of a friend's capbility. 
	public func getCapabilityVersion(capability:FriendCapability) -> Float
	{
		return linphone_friend_get_capability_version(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue)))
	}
	///	Get the presence model for a specific SIP URI or phone number of a friend. 
	/// - Parameter uriOrTel: The SIP URI or phone number for which to get the presence
	/// model 
	/// 
	/// 
	/// - Returns: A `PresenceModel` object, or nil if the friend do not have presence
	/// information for this SIP URI or phone number 
	public func getPresenceModelForUriOrTel(uriOrTel:String) -> PresenceModel?
	{
		let cPointer = linphone_friend_get_presence_model_for_uri_or_tel(cPtr, uriOrTel)
		if (cPointer == nil) {
			return nil
		}
		return PresenceModel.getSwiftObject(cObject: cPointer!)
	}
	///	Returns whether or not a friend has a capbility. 
	/// - Parameter capability: LinphoneFriendCapability object 
	/// 
	/// 
	/// - Returns: whether or not a friend has a capbility 
	public func hasCapability(capability:FriendCapability) -> Bool
	{
		return linphone_friend_has_capability(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue))) != 0
	}
	///	Returns whether or not a friend has a capbility with a given version. 
	/// - Parameter capability: LinphoneFriendCapability object 
	/// - Parameter version: the version to test 
	/// 
	/// 
	/// - Returns: whether or not a friend has a capbility with a given version or -1.0
	/// if friend has not capability. 
	public func hasCapabilityWithVersion(capability:FriendCapability, version:Float) -> Bool
	{
		return linphone_friend_has_capability_with_version(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue)), version) != 0
	}
	///	Returns whether or not a friend has a capbility with a given version or more. 
	/// - Parameter capability: LinphoneFriendCapability object 
	/// - Parameter version: the version to test 
	/// 
	/// 
	/// - Returns: whether or not a friend has a capbility with a given version or
	/// more. 
	public func hasCapabilityWithVersionOrMore(capability:FriendCapability, version:Float) -> Bool
	{
		return linphone_friend_has_capability_with_version_or_more(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue)), version) != 0
	}
	///	Check that the given friend is in a friend list. 
	/// - Returns:  if the friend is in a friend list, true otherwise. 
	public func inList() -> Bool
	{
		return linphone_friend_in_list(cPtr) != 0
	}
	///	Removes a friend from it's friend list and from the rc if exists. 
	public func remove() 
	{
		linphone_friend_remove(cPtr)
	}
	///	Removes an address in this friend. 
	/// - Parameter addr: `Address` object 
	/// 
	public func removeAddress(addr:Address) 
	{
		linphone_friend_remove_address(cPtr, addr.cPtr)
	}
	///	Removes a phone number in this friend. 
	/// - Parameter phone: number to remove 
	/// 
	public func removePhoneNumber(phone:String) 
	{
		linphone_friend_remove_phone_number(cPtr, phone)
	}
	///	Saves a friend either in database if configured, otherwise in linphonerc. 
	/// - Parameter lc: the linphone core 
	/// 
	public func save(lc:Core) 
	{
		linphone_friend_save(cPtr, lc.cPtr)
	}
	///	Set the presence model for a specific SIP URI or phone number of a friend. 
	/// - Parameter uriOrTel: The SIP URI or phone number for which to set the presence
	/// model 
	/// - Parameter presence: The `PresenceModel` object to set 
	/// 
	public func setPresenceModelForUriOrTel(uriOrTel:String, presence:PresenceModel) 
	{
		linphone_friend_set_presence_model_for_uri_or_tel(cPtr, uriOrTel, presence.cPtr)
	}
}

/// The `FriendList` object representing a list of friends. 
public class FriendList : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> FriendList {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<FriendList>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = FriendList(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	///Enum describing the status of a CardDAV synchronization. 
	public enum SyncStatus:Int
	{
		case Started = 0
		case Successful = 1
		case Failure = 2
	}

	///Enum describing the status of a LinphoneFriendList operation. 
	public enum Status:Int
	{
		case OK = 0
		case NonExistentFriend = 1
		case InvalidFriend = 2
	}
	public func getDelegate() -> FriendListDelegate?
	{
		let cObject = linphone_friend_list_get_callbacks(cPtr)
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<FriendListDelegate>.fromOpaque(result!).takeUnretainedValue()
			}
		return nil
	}
	public func addDelegate(delegate: FriendListDelegate)
	{
		linphone_friend_list_add_callbacks(cPtr, delegate.cPtr)
	}
	public func removeDelegate(delegate: FriendListDelegate)
	{
		linphone_friend_list_remove_callbacks(cPtr, delegate.cPtr)
	}

	/// Returns the `Core` object attached to this LinphoneFriendList. 
	/// - Returns: a `Core` object 
	public var core: Core?
	{
			let cPointer = linphone_friend_list_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Core.getSwiftObject(cObject:cPointer!)
	}

	/// Get the current LinphoneFriendListCbs object associated with a
	/// LinphoneFriendList. 
	/// - Returns: The current LinphoneFriendListCbs object associated with the
	/// LinphoneFriendList. 
	public var currentCallbacks: FriendListDelegate?
	{
			let cObject = linphone_friend_list_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<FriendListDelegate>.fromOpaque(result!).takeUnretainedValue()
				}
			return nil
	}

	/// Get the display name of the friend list. 
	/// - Returns: The display name of the friend list. 
	public var displayName: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_friend_list_get_display_name(cPtr))
		}
		set
		{
			linphone_friend_list_set_display_name(cPtr, newValue)
		}
	}

	/// Retrieves the list of `Friend` from this LinphoneFriendList. 
	/// - Returns: A list of `Friend` objects. LinphoneFriend  a list of `Friend` 
	public var friends: [Friend]
	{
			var swiftList = [Friend]()
			var cList = linphone_friend_list_get_friends(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Friend.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Get wheter the subscription of the friend list is bodyless or not. 
	/// - Returns: Wheter the subscription of the friend list is bodyless or not. 
	public var isSubscriptionBodyless: Bool
	{
			return linphone_friend_list_is_subscription_bodyless(cPtr) != 0
	}

	/// Get the RLS (Resource List Server) URI associated with the friend list to
	/// subscribe to these friends presence. 
	/// - Returns: The RLS URI associated with the friend list. 
	public var rlsAddress: Address?
	{
		get
		{
			let cPointer = linphone_friend_list_get_rls_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_friend_list_set_rls_address(cPtr, newValue?.cPtr)
		}
	}

	/// Get the RLS (Resource List Server) URI associated with the friend list to
	/// subscribe to these friends presence. 
	/// - Returns: The RLS URI associated with the friend list. 
	public var rlsUri: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_friend_list_get_rls_uri(cPtr))
		}
		set
		{
			linphone_friend_list_set_rls_uri(cPtr, newValue)
		}
	}

	/// Set wheter the subscription of the friend list is bodyless or not. 
	public var subscriptionBodyless: Bool?
	{
		willSet
		{
			linphone_friend_list_set_subscription_bodyless(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets whether subscription to NOTIFYes of all friends list are enabled or not. 
	/// - Returns: Whether subscriptions are enabled or not 
	public var subscriptionsEnabled: Bool
	{
		get
		{
			return linphone_friend_list_subscriptions_enabled(cPtr) != 0
		}
		set
		{
			linphone_friend_list_enable_subscriptions(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the URI associated with the friend list. 
	/// - Returns: The URI associated with the friend list. 
	public var uri: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_friend_list_get_uri(cPtr))
		}
		set
		{
			linphone_friend_list_set_uri(cPtr, newValue)
		}
	}

	/// Retrieve the user pointer associated with the friend list. 
	/// - Returns: The user pointer associated with the friend list. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_friend_list_get_user_data(cPtr)
		}
		set
		{
			linphone_friend_list_set_user_data(cPtr, newValue)
		}
	}
	///	Add a friend to a friend list. 
	/// If or when a remote CardDAV server will be attached to the list, the friend
	/// will be sent to the server. 
	/// 
	/// - Parameter lf: `Friend` object to add to the friend list. 
	/// 
	/// 
	/// - Returns: #LinphoneFriendListOK if successfully added,
	/// #LinphoneFriendListInvalidFriend if the friend is not valid. 
	public func addFriend(lf:Friend) -> FriendList.Status
	{
		return FriendList.Status(rawValue: Int(linphone_friend_list_add_friend(cPtr, lf.cPtr).rawValue))!
	}
	///	Add a friend to a friend list. 
	/// The friend will never be sent to a remote CardDAV server. Warning!
	/// #LinphoneFriends added this way will be removed on the next synchronization,
	/// and the callback contact_deleted will be called. 
	/// 
	/// - Parameter lf: `Friend` object to add to the friend list. 
	/// 
	/// 
	/// - Returns: #LinphoneFriendListOK if successfully added,
	/// #LinphoneFriendListInvalidFriend if the friend is not valid. 
	public func addLocalFriend(lf:Friend) -> FriendList.Status
	{
		return FriendList.Status(rawValue: Int(linphone_friend_list_add_local_friend(cPtr, lf.cPtr).rawValue))!
	}
	///	Creates and export `Friend` objects from `FriendList` to a file using vCard 4
	///	format. 
	/// - Parameter vcardFile: the path to a file that will contain the vCards 
	/// 
	public func exportFriendsAsVcard4File(vcardFile:String) 
	{
		linphone_friend_list_export_friends_as_vcard4_file(cPtr, vcardFile)
	}
	///	Find a friend in the friend list using a LinphoneAddress. 
	/// - Parameter address: `Address` object of the friend we want to search for. 
	/// 
	/// 
	/// - Returns: A `Friend` if found, nil otherwise. 
	public func findFriendByAddress(address:Address) -> Friend?
	{
		let cPointer = linphone_friend_list_find_friend_by_address(cPtr, address.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return Friend.getSwiftObject(cObject: cPointer!)
	}
	///	Find a friend in the friend list using a ref key. 
	/// - Parameter refKey: The ref key string of the friend we want to search for. 
	/// 
	/// 
	/// - Returns: A `Friend` if found, nil otherwise. 
	public func findFriendByRefKey(refKey:String) -> Friend?
	{
		let cPointer = linphone_friend_list_find_friend_by_ref_key(cPtr, refKey)
		if (cPointer == nil) {
			return nil
		}
		return Friend.getSwiftObject(cObject: cPointer!)
	}
	///	Find a friend in the friend list using an URI string. 
	/// - Parameter uri: A string containing the URI of the friend we want to search
	/// for. 
	/// 
	/// 
	/// - Returns: A `Friend` if found, nil otherwise. 
	public func findFriendByUri(uri:String) -> Friend?
	{
		let cPointer = linphone_friend_list_find_friend_by_uri(cPtr, uri)
		if (cPointer == nil) {
			return nil
		}
		return Friend.getSwiftObject(cObject: cPointer!)
	}
	///	Find all friends in the friend list using a LinphoneAddress. 
	/// - Parameter address: `Address` object of the friends we want to search for. 
	/// 
	/// 
	/// - Returns: A list of `Friend` objects. LinphoneFriend  as a list of `Friend` if
	/// found, nil otherwise. 
	public func findFriendsByAddress(address:Address) -> [Friend]
	{
		var swiftList = [Friend]()
		var cList = linphone_friend_list_find_friends_by_address(cPtr, address.cPtr)
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(Friend.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Find all friends in the friend list using an URI string. 
	/// - Parameter uri: A string containing the URI of the friends we want to search
	/// for. 
	/// 
	/// 
	/// - Returns: A list of `Friend` objects. LinphoneFriend  as a list of `Friend` if
	/// found, nil otherwise. 
	public func findFriendsByUri(uri:String) -> [Friend]
	{
		var swiftList = [Friend]()
		var cList = linphone_friend_list_find_friends_by_uri(cPtr, uri)
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(Friend.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Creates and adds `Friend` objects to `FriendList` from a buffer that contains
	///	the vCard(s) to parse. 
	/// - Parameter vcardBuffer: the buffer that contains the vCard(s) to parse 
	/// 
	/// 
	/// - Returns: the amount of linphone friends created 
	public func importFriendsFromVcard4Buffer(vcardBuffer:String) throws 
	{
		let exception_result = linphone_friend_list_import_friends_from_vcard4_buffer(cPtr, vcardBuffer)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "importFriendsFromVcard4Buffer returned value \(exception_result)")
		}
	}
	///	Creates and adds `Friend` objects to `FriendList` from a file that contains the
	///	vCard(s) to parse. 
	/// - Parameter vcardFile: the path to a file that contains the vCard(s) to parse 
	/// 
	/// 
	/// - Returns: the amount of linphone friends created 
	public func importFriendsFromVcard4File(vcardFile:String) throws 
	{
		let exception_result = linphone_friend_list_import_friends_from_vcard4_file(cPtr, vcardFile)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "importFriendsFromVcard4File returned value \(exception_result)")
		}
	}
	///	Notify our presence to all the friends in the friend list that have subscribed
	///	to our presence directly (not using a RLS). 
	/// - Parameter presence: `PresenceModel` object. 
	/// 
	public func notifyPresence(presence:PresenceModel) 
	{
		linphone_friend_list_notify_presence(cPtr, presence.cPtr)
	}
	///	Remove a friend from a friend list. 
	/// - Parameter lf: `Friend` object to remove from the friend list. 
	/// 
	/// 
	/// - Returns: #LinphoneFriendListOK if removed successfully,
	/// #LinphoneFriendListNonExistentFriend if the friend is not in the list. 
	public func removeFriend(lf:Friend) -> FriendList.Status
	{
		return FriendList.Status(rawValue: Int(linphone_friend_list_remove_friend(cPtr, lf.cPtr).rawValue))!
	}
	///	Starts a CardDAV synchronization using value set using
	///	linphone_friend_list_set_uri. 
	public func synchronizeFriendsFromServer() 
	{
		linphone_friend_list_synchronize_friends_from_server(cPtr)
	}
	///	Goes through all the `Friend` that are dirty and does a CardDAV PUT to update
	///	the server. 
	public func updateDirtyFriends() 
	{
		linphone_friend_list_update_dirty_friends(cPtr)
	}
	///	Sets the revision from the last synchronization. 
	/// - Parameter rev: The revision 
	/// 
	public func updateRevision(rev:Int) 
	{
		linphone_friend_list_update_revision(cPtr, CInt(rev))
	}
	///	Update presence subscriptions for the entire list. 
	/// Calling this function is necessary when list subscriptions are enabled, ie when
	/// a RLS presence server is used. 
	public func updateSubscriptions() 
	{
		linphone_friend_list_update_subscriptions(cPtr)
	}
}

/// Object representing a chain of protocol headers. 
/// It provides read/write access to the headers of the underlying protocol. 
public class Headers : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Headers {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Headers>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Headers(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///	Add given header name and corresponding value. 
	/// - Parameter name: the header's name 
	/// 
	public func add(name:String, value:String) 
	{
		linphone_headers_add(cPtr, name, value)
	}
	///	Search for a given header name and return its value. 
	/// - Returns: the header's value or nil if not found. 
	public func getValue(headerName:String) -> String
	{
		return charArrayToString(charPointer: linphone_headers_get_value(cPtr, headerName))
	}
	///	Add given header name and corresponding value. 
	/// - Parameter name: the header's name 
	/// 
	public func remove(name:String) 
	{
		linphone_headers_remove(cPtr, name)
	}
}

/// Policy to use to send/receive instant messaging composing/delivery/display
/// notifications. 
/// The sending of this information is done as in the RFCs 3994 (is_composing) and
/// 5438 (imdn delivered/displayed). 
public class ImNotifPolicy : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> ImNotifPolicy {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ImNotifPolicy>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ImNotifPolicy(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Tell whether imdn delivered notifications are being notified when received. 
	/// - Returns: Boolean value telling whether imdn delivered notifications are being
	/// notified when received. 
	public var recvImdnDelivered: Bool
	{
		get
		{
			return linphone_im_notif_policy_get_recv_imdn_delivered(cPtr) != 0
		}
		set
		{
			linphone_im_notif_policy_set_recv_imdn_delivered(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether imdn displayed notifications are being notified when received. 
	/// - Returns: Boolean value telling whether imdn displayed notifications are being
	/// notified when received. 
	public var recvImdnDisplayed: Bool
	{
		get
		{
			return linphone_im_notif_policy_get_recv_imdn_displayed(cPtr) != 0
		}
		set
		{
			linphone_im_notif_policy_set_recv_imdn_displayed(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether is_composing notifications are being notified when received. 
	/// - Returns: Boolean value telling whether is_composing notifications are being
	/// notified when received. 
	public var recvIsComposing: Bool
	{
		get
		{
			return linphone_im_notif_policy_get_recv_is_composing(cPtr) != 0
		}
		set
		{
			linphone_im_notif_policy_set_recv_is_composing(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether imdn delivered notifications are being sent. 
	/// - Returns: Boolean value telling whether imdn delivered notifications are being
	/// sent. 
	public var sendImdnDelivered: Bool
	{
		get
		{
			return linphone_im_notif_policy_get_send_imdn_delivered(cPtr) != 0
		}
		set
		{
			linphone_im_notif_policy_set_send_imdn_delivered(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether imdn displayed notifications are being sent. 
	/// - Returns: Boolean value telling whether imdn displayed notifications are being
	/// sent. 
	public var sendImdnDisplayed: Bool
	{
		get
		{
			return linphone_im_notif_policy_get_send_imdn_displayed(cPtr) != 0
		}
		set
		{
			linphone_im_notif_policy_set_send_imdn_displayed(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether is_composing notifications are being sent. 
	/// - Returns: Boolean value telling whether is_composing notifications are being
	/// sent. 
	public var sendIsComposing: Bool
	{
		get
		{
			return linphone_im_notif_policy_get_send_is_composing(cPtr) != 0
		}
		set
		{
			linphone_im_notif_policy_set_send_is_composing(cPtr, newValue==true ? 1:0)
		}
	}

	/// Retrieve the user pointer associated with the `ImNotifPolicy` object. 
	/// - Returns: The user pointer associated with the `ImNotifPolicy` object. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_im_notif_policy_get_user_data(cPtr)
		}
		set
		{
			linphone_im_notif_policy_set_user_data(cPtr, newValue)
		}
	}
	///	Clear an IM notif policy (deactivate all receiving and sending of
	///	notifications). 
	public func clear() 
	{
		linphone_im_notif_policy_clear(cPtr)
	}
	///	Enable all receiving and sending of notifications. 
	public func enableAll() 
	{
		linphone_im_notif_policy_enable_all(cPtr)
	}
}

/// The `InfoMessage` is an object representing an informational message sent or
/// received by the core. 
public class InfoMessage : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> InfoMessage {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<InfoMessage>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = InfoMessage(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Returns the info message's content as a `Content` structure. 
	public var content: Content?
	{
		get
		{
			let cPointer = linphone_info_message_get_content(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Content.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_info_message_set_content(cPtr, newValue?.cPtr)
		}
	}
	///	Add a header to an info message to be sent. 
	/// - Parameter name: the header'name 
	/// - Parameter value: the header's value 
	/// 
	public func addHeader(name:String, value:String) 
	{
		linphone_info_message_add_header(cPtr, name, value)
	}
	///	Obtain a header value from a received info message. 
	/// - Parameter name: the header'name 
	/// 
	/// 
	/// - Returns: the corresponding header's value, or nil if not exists. 
	public func getHeader(name:String) -> String
	{
		return charArrayToString(charPointer: linphone_info_message_get_header(cPtr, name))
	}
}

/// Singleton class giving access to logging features. 
public class LoggingService : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> LoggingService {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<LoggingService>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = LoggingService(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	public func getDelegate() -> LoggingServiceDelegate?
	{
		let cObject = linphone_logging_service_get_callbacks(cPtr)
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<LoggingServiceDelegate>.fromOpaque(result!).takeUnretainedValue()
			}
		return nil
	}
	public func addDelegate(delegate: LoggingServiceDelegate)
	{
		linphone_logging_service_add_callbacks(cPtr, delegate.cPtr)
	}
	public func removeDelegate(delegate: LoggingServiceDelegate)
	{
		linphone_logging_service_remove_callbacks(cPtr, delegate.cPtr)
	}

	/// Gets the singleton logging service object. 
	/// The singleton is automatically instantiated if it hasn't been done yet.
	/// 
	/// - Returns: A pointer on the singleton. 
	static public var Instance: LoggingService
	{
			return LoggingService.getSwiftObject(cObject:linphone_logging_service_get())
	}

	/// Returns the current callbacks being called while iterating on callbacks. 
	/// - Returns: A pointer to the current LinphoneLoggingServiceCbs object 
	public var currentCallbacks: LoggingServiceDelegate?
	{
			let cObject = linphone_logging_service_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<LoggingServiceDelegate>.fromOpaque(result!).takeUnretainedValue()
				}
			return nil
	}

	/// Get the domain where application logs are written (for example with {@link
	/// LoggingService#message}). 
	public var domain: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_logging_service_get_domain(cPtr))
		}
		set
		{
			linphone_logging_service_set_domain(cPtr, newValue)
		}
	}

	/// Set the verbosity of the log. 
	/// For instance, a level of LinphoneLogLevelMessage will let pass fatal, error,
	/// warning and message-typed messages whereas trace and debug messages will be
	/// dumped out. 
	public var logLevel: LogLevel?
	{
		willSet
		{
			linphone_logging_service_set_log_level(cPtr, LinphoneLogLevel(rawValue: CUnsignedInt(newValue!.rawValue)))
		}
	}

	/// Gets the log level mask. 
	public var logLevelMask: UInt
	{
		get
		{
			return UInt(linphone_logging_service_get_log_level_mask(cPtr))
		}
		set
		{
			linphone_logging_service_set_log_level_mask(cPtr, CUnsignedInt(newValue))
		}
	}
	///	Write a LinphoneLogLevelDebug message to the logs. 
	/// - Parameter msg: The log message. 
	/// 
	public func debug(msg:String) 
	{
		linphone_logging_service_debug(cPtr, msg)
	}
	///	Write a LinphoneLogLevelError message to the logs. 
	/// - Parameter msg: The log message. 
	/// 
	public func error(msg:String) 
	{
		linphone_logging_service_error(cPtr, msg)
	}
	///	Write a LinphoneLogLevelFatal message to the logs. 
	/// - Parameter msg: The log message. 
	/// 
	public func fatal(msg:String) 
	{
		linphone_logging_service_fatal(cPtr, msg)
	}
	///	Write a LinphoneLogLevelMessage message to the logs. 
	/// - Parameter msg: The log message. 
	/// 
	public func message(msg:String) 
	{
		linphone_logging_service_message(cPtr, msg)
	}
	///	Enables logging in a file. 
	/// That function enables an internal log handler that writes log messages in
	/// log-rotated files.
	/// 
	/// - Parameter dir: Directory where to create the distinct parts of the log. 
	/// - Parameter filename: Name of the log file. 
	/// - Parameter maxSize: The maximal size of each part of the log. The log rotating
	/// is triggered each time the currently opened log part reach that limit. 
	/// 
	public func setLogFile(dir:String, filename:String, maxSize:Int) 
	{
		linphone_logging_service_set_log_file(cPtr, dir, filename, maxSize)
	}
	///	Write a LinphoneLogLevelTrace message to the logs. 
	/// - Parameter msg: The log message. 
	/// 
	public func trace(msg:String) 
	{
		linphone_logging_service_trace(cPtr, msg)
	}
	///	Write a LinphoneLogLevelWarning message to the logs. 
	/// - Parameter msg: The log message. 
	/// 
	public func warning(msg:String) 
	{
		linphone_logging_service_warning(cPtr, msg)
	}
}

/// A `MagicSearch` is used to do specifics searchs. 
public class MagicSearch : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> MagicSearch {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<MagicSearch>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = MagicSearch(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// - Returns: the delimiter used to find matched filter word 
	public var delimiter: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_magic_search_get_delimiter(cPtr))
		}
		set
		{
			linphone_magic_search_set_delimiter(cPtr, newValue)
		}
	}

	/// - Returns: if the search is limited 
	public var limitedSearch: Bool
	{
		get
		{
			return linphone_magic_search_get_limited_search(cPtr) != 0
		}
		set
		{
			linphone_magic_search_set_limited_search(cPtr, newValue==true ? 1:0)
		}
	}

	/// - Returns: the maximum value used to calculate the weight in search 
	public var maxWeight: UInt
	{
		get
		{
			return UInt(linphone_magic_search_get_max_weight(cPtr))
		}
		set
		{
			linphone_magic_search_set_max_weight(cPtr, CUnsignedInt(newValue))
		}
	}

	/// - Returns: the minimum value used to calculate the weight in search 
	public var minWeight: UInt
	{
		get
		{
			return UInt(linphone_magic_search_get_min_weight(cPtr))
		}
		set
		{
			linphone_magic_search_set_min_weight(cPtr, CUnsignedInt(newValue))
		}
	}

	/// - Returns: the number of the maximum SearchResult which will be return 
	public var searchLimit: UInt
	{
		get
		{
			return UInt(linphone_magic_search_get_search_limit(cPtr))
		}
		set
		{
			linphone_magic_search_set_search_limit(cPtr, CUnsignedInt(newValue))
		}
	}

	/// - Returns: if the delimiter search is used 
	public var useDelimiter: Bool
	{
		get
		{
			return linphone_magic_search_get_use_delimiter(cPtr) != 0
		}
		set
		{
			linphone_magic_search_set_use_delimiter(cPtr, newValue==true ? 1:0)
		}
	}
	///	Create a sorted list of SearchResult from SipUri, Contact name, Contact
	///	displayname, Contact phone number, which match with a filter word The last item
	///	list will be an address formed with "filter" if a proxy config exist During the
	///	first search, a cache is created and used for the next search Use {@link
	///	MagicSearch#resetSearchCache} to begin a new search. 
	/// - Parameter filter: word we search 
	/// - Parameter domain: domain which we want to search only
	/// 
	/// 
	/// 
	/// - Returns: sorted list of A list of `SearchResult` objects.
	/// LinphoneSearchResult  The objects inside the list are freshly allocated with a
	/// reference counter equal to one, so they need to be freed on list destruction
	/// with bctbx_list_free_with_data() for instance.   
	public func getContactListFromFilter(filter:String, domain:String) -> [SearchResult]
	{
		var swiftList = [SearchResult]()
		var cList = linphone_magic_search_get_contact_list_from_filter(cPtr, filter, domain)
		while (cList != nil) {
			let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
			swiftList.append(SearchResult.getSwiftObject(cObject: data))
			cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
		}
		return swiftList
	}
	///	Reset the cache to begin a new search. 
	public func resetSearchCache() 
	{
		linphone_magic_search_reset_search_cache(cPtr)
	}
}

/// Policy to use to pass through NATs/firewalls. 
public class NatPolicy : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> NatPolicy {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<NatPolicy>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = NatPolicy(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Returns the `Core` object managing this nat policy, if any. 
	public var core: Core?
	{
			let cPointer = linphone_nat_policy_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Core.getSwiftObject(cObject:cPointer!)
	}

	/// Tell whether ICE is enabled. 
	/// - Returns: Boolean value telling whether ICE is enabled. 
	public var iceEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_ice_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_ice(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether STUN is enabled. 
	/// - Returns: Boolean value telling whether STUN is enabled. 
	public var stunEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_stun_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_stun(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the STUN/TURN server to use with this NAT policy. 
	/// Used when STUN or TURN are enabled. 
	/// 
	/// - Returns: The STUN server used by this NAT policy. 
	public var stunServer: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_nat_policy_get_stun_server(cPtr))
		}
		set
		{
			linphone_nat_policy_set_stun_server(cPtr, newValue)
		}
	}

	/// Get the username used to authenticate with the STUN/TURN server. 
	/// The authentication will search for a `AuthInfo` with this username. If it is
	/// not set the username of the currently used `ProxyConfig` is used to search for
	/// a LinphoneAuthInfo. 
	/// 
	/// - Returns: The username used to authenticate with the STUN/TURN server. 
	public var stunServerUsername: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_nat_policy_get_stun_server_username(cPtr))
		}
		set
		{
			linphone_nat_policy_set_stun_server_username(cPtr, newValue)
		}
	}

	/// Tells whether TCP TURN transport is enabled. 
	/// Used when TURN is enabled. 
	/// 
	/// - Returns: Boolean value telling whether TCP TURN transport is enabled. 
	public var tcpTurnTransportEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_tcp_turn_transport_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_tcp_turn_transport(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether TLS TURN transport is enabled. 
	/// Used when TURN is enabled. 
	/// 
	/// - Returns: Boolean value telling whether TLS TURN transport is enabled. 
	public var tlsTurnTransportEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_tls_turn_transport_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_tls_turn_transport(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether TURN is enabled. 
	/// - Returns: Boolean value telling whether TURN is enabled. 
	public var turnEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_turn_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_turn(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether UDP TURN transport is enabled. 
	/// Used when TURN is enabled. 
	/// 
	/// - Returns: Boolean value telling whether UDP TURN transport is enabled. 
	public var udpTurnTransportEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_udp_turn_transport_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_udp_turn_transport(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether uPnP is enabled. 
	/// - Returns: Boolean value telling whether uPnP is enabled. 
	public var upnpEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_upnp_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_upnp(cPtr, newValue==true ? 1:0)
		}
	}

	/// Retrieve the user pointer associated with the `NatPolicy` object. 
	/// - Returns: The user pointer associated with the `NatPolicy` object. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_nat_policy_get_user_data(cPtr)
		}
		set
		{
			linphone_nat_policy_set_user_data(cPtr, newValue)
		}
	}
	///	Clear a NAT policy (deactivate all protocols and unset the STUN server). 
	public func clear() 
	{
		linphone_nat_policy_clear(cPtr)
	}
	///	Start a STUN server DNS resolution. 
	public func resolveStunServer() 
	{
		linphone_nat_policy_resolve_stun_server(cPtr)
	}
}

public class Participant : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Participant {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Participant>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Participant(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Get the address of a conference participant. 
	/// - Returns: The address of the participant 
	public var address: Address?
	{
			let cPointer = linphone_participant_get_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Gets the list of devices from a chat room's participant. 
	/// - Returns: A list of LinphoneParticipantDevice objects.
	/// LinphoneParticipantDevice  
	public var devices: [ParticipantDevice]
	{
			var swiftList = [ParticipantDevice]()
			var cList = linphone_participant_get_devices(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(ParticipantDevice.getSwiftObject(cObject: data))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Tells whether a conference participant is an administrator of the conference. 
	/// - Returns: A boolean value telling whether the participant is an administrator 
	public var isAdmin: Bool
	{
			return linphone_participant_is_admin(cPtr) != 0
	}

	/// Get the security level of a chat room. 
	/// - Returns: The security level of the chat room 
	public var securityLevel: ChatRoomSecurityLevel
	{
			return ChatRoomSecurityLevel(rawValue: Int(linphone_participant_get_security_level(cPtr).rawValue))!
	}

	/// Retrieve the user pointer associated with the conference participant. 
	/// - Returns: The user pointer associated with the participant. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_participant_get_user_data(cPtr)
		}
		set
		{
			linphone_participant_set_user_data(cPtr, newValue)
		}
	}
	///	Find a device in the list of devices from a chat room's participant. 
	/// - Parameter address: A `Address` object 
	/// 
	/// 
	/// - Returns: a #LinphoneParticipantDevice or nil if not found 
	public func findDevice(address:Address) -> ParticipantDevice?
	{
		let cPointer = linphone_participant_find_device(cPtr, address.cPtr)
		if (cPointer == nil) {
			return nil
		}
		return ParticipantDevice.getSwiftObject(cObject: cPointer!)
	}
}

public class ParticipantDevice : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> ParticipantDevice {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ParticipantDevice>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ParticipantDevice(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Get the address of a participant's device. 
	/// - Returns: The address of the participant's device 
	public var address: Address?
	{
			let cPointer = linphone_participant_device_get_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Return the name of the device or nil. 
	/// - Returns: the name of the device or nil 
	public var name: String
	{
			return charArrayToString(charPointer: linphone_participant_device_get_name(cPtr))
	}

	/// Get the security level of a participant's device. 
	/// - Returns: The security level of the device 
	public var securityLevel: ChatRoomSecurityLevel
	{
			return ChatRoomSecurityLevel(rawValue: Int(linphone_participant_device_get_security_level(cPtr).rawValue))!
	}

	/// Retrieve the user pointer associated with the participant's device. 
	/// - Returns: The user pointer associated with the participant's device. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_participant_device_get_user_data(cPtr)
		}
		set
		{
			linphone_participant_device_set_user_data(cPtr, newValue)
		}
	}
}

public class ParticipantDeviceIdentity : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> ParticipantDeviceIdentity {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ParticipantDeviceIdentity>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ParticipantDeviceIdentity(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///	Clones a #LinphoneParticipantDeviceIdentity object. 
	public func clone() -> ParticipantDeviceIdentity?
	{
		let cPointer = linphone_participant_device_identity_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		return ParticipantDeviceIdentity.getSwiftObject(cObject: cPointer!)
	}
}

/// The LinphoneParticipantImdnState object represents the state of chat message
/// for a participant of a conference chat room. 
public class ParticipantImdnState : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> ParticipantImdnState {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ParticipantImdnState>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ParticipantImdnState(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Get the participant concerned by a LinphoneParticipantImdnState. 
	/// - Returns: The participant concerned by the LinphoneParticipantImdnState 
	public var participant: Participant?
	{
			let cPointer = linphone_participant_imdn_state_get_participant(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Participant.getSwiftObject(cObject:cPointer!)
	}

	/// Get the chat message state the participant is in. 
	/// - Returns: The chat message state the participant is in 
	public var state: ChatMessage.State
	{
			return ChatMessage.State(rawValue: Int(linphone_participant_imdn_state_get_state(cPtr).rawValue))!
	}

	/// Get the timestamp at which a participant has reached the state described by a
	/// LinphoneParticipantImdnState. 
	/// - Returns: The timestamp at which the participant has reached the state
	/// described in the LinphoneParticipantImdnState 
	public var stateChangeTime: time_t
	{
			return linphone_participant_imdn_state_get_state_change_time(cPtr)
	}

	/// Retrieve the user pointer associated with a LinphoneParticipantImdnState. 
	/// - Returns: The user pointer associated with the LinphoneParticipantImdnState. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_participant_imdn_state_get_user_data(cPtr)
		}
		set
		{
			linphone_participant_imdn_state_set_user_data(cPtr, newValue)
		}
	}
}

/// Object representing an RTP payload type. 
public class PayloadType : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> PayloadType {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PayloadType>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PayloadType(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Get the number of channels. 
	/// - Returns: The number of channels. 
	public var channels: Int
	{
			return Int(linphone_payload_type_get_channels(cPtr))
	}

	/// Get the clock rate of a payload type. 
	/// - Returns: [in] The clock rate in Hz. 
	public var clockRate: Int
	{
			return Int(linphone_payload_type_get_clock_rate(cPtr))
	}

	/// Return a string describing a payload type. 
	/// The format of the string is <mime_type>/<clock_rate>/<channels>. 
	/// 
	/// - Returns: The description of the payload type. Must be release after use. 
	public var description: String
	{
			return charArrayToString(charPointer: linphone_payload_type_get_description(cPtr))
	}

	/// Get a description of the encoder used to provide a payload type. 
	/// - Returns: The description of the encoder. Can be nil if the payload type is
	/// not supported by Mediastreamer2. 
	public var encoderDescription: String
	{
			return charArrayToString(charPointer: linphone_payload_type_get_encoder_description(cPtr))
	}

	/// Check whether the payload is usable according the bandwidth targets set in the
	/// core. 
	/// - Returns:  if the payload type is usable. 
	public var isUsable: Bool
	{
			return linphone_payload_type_is_usable(cPtr) != 0
	}

	/// Tells whether the specified payload type represents a variable bitrate codec. 
	/// - Returns:  if the payload type represents a VBR codec, true instead. 
	public var isVbr: Bool
	{
			return linphone_payload_type_is_vbr(cPtr) != 0
	}

	/// Get the mime type. 
	/// - Returns: The mime type. 
	public var mimeType: String
	{
			return charArrayToString(charPointer: linphone_payload_type_get_mime_type(cPtr))
	}

	/// Get the normal bitrate in bits/s. 
	/// - Returns: The normal bitrate in bits/s or -1 if an error has occured. 
	public var normalBitrate: Int
	{
		get
		{
			return Int(linphone_payload_type_get_normal_bitrate(cPtr))
		}
		set
		{
			linphone_payload_type_set_normal_bitrate(cPtr, CInt(newValue))
		}
	}

	/// Returns the payload type number assigned for this codec. 
	/// - Returns: The number of the payload type. 
	public var number: Int
	{
		get
		{
			return Int(linphone_payload_type_get_number(cPtr))
		}
		set
		{
			linphone_payload_type_set_number(cPtr, CInt(newValue))
		}
	}

	/// Get the format parameters for incoming streams. 
	/// - Returns: The format parameters as string. 
	public var recvFmtp: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_payload_type_get_recv_fmtp(cPtr))
		}
		set
		{
			linphone_payload_type_set_recv_fmtp(cPtr, newValue)
		}
	}

	/// Get the format parameters for outgoing streams. 
	/// - Returns: The format parameters as string. 
	public var sendFmtp: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_payload_type_get_send_fmtp(cPtr))
		}
		set
		{
			linphone_payload_type_set_send_fmtp(cPtr, newValue)
		}
	}

	/// Get the type of a payload type. 
	/// - Returns: The type of the payload e.g. PAYLOAD_AUDIO_CONTINUOUS or
	/// PAYLOAD_VIDEO. 
	public var type: Int
	{
			return Int(linphone_payload_type_get_type(cPtr))
	}
	///	Enable/disable a payload type. 
	/// - Parameter enabled: Set true for enabling and true for disabling. 
	/// 
	/// 
	/// - Returns: 0 for success, -1 for failure. 
	public func enable(enabled:Bool) -> Int
	{
		return Int(linphone_payload_type_enable(cPtr, enabled==true ? 1:0))
	}
	///	Check whether a palyoad type is enabled. 
	/// - Returns:  if enabled, true if disabled. 
	public func enabled() -> Bool
	{
		return linphone_payload_type_enabled(cPtr) != 0
	}
}

/// Player interface. 
public class Player : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Player {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Player>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Player(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	///The state of a LinphonePlayer. 
	public enum State:Int
	{
		/// No file is opened for playing. 
		case Closed = 0
		/// The player is paused. 
		case Paused = 1
		/// The player is playing. 
		case Playing = 2
	}
	public func getDelegate() -> PlayerDelegate?
	{
		let cObject = linphone_player_get_callbacks(cPtr)
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PlayerDelegate>.fromOpaque(result!).takeUnretainedValue()
			}
		return nil
	}
	public func addDelegate(delegate: PlayerDelegate)
	{
		linphone_player_add_callbacks(cPtr, delegate.cPtr)
	}
	public func removeDelegate(delegate: PlayerDelegate)
	{
		linphone_player_remove_callbacks(cPtr, delegate.cPtr)
	}

	/// Returns the `Core` object managing this player's call, if any. 
	public var core: Core?
	{
			let cPointer = linphone_player_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Core.getSwiftObject(cObject:cPointer!)
	}

	/// Returns the current LinphonePlayerCbsCbs object. 
	/// - Returns: The current LinphonePlayerCbs object 
	public var currentCallbacks: PlayerDelegate?
	{
			let cObject = linphone_player_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<PlayerDelegate>.fromOpaque(result!).takeUnretainedValue()
				}
			return nil
	}

	/// Get the current position in the opened file. 
	/// - Returns: The current position in the opened file 
	public var currentPosition: Int
	{
			return Int(linphone_player_get_current_position(cPtr))
	}

	/// Get the duration of the opened file. 
	/// - Returns: The duration of the opened file 
	public var duration: Int
	{
			return Int(linphone_player_get_duration(cPtr))
	}

	/// Get the current state of a player. 
	/// - Returns: The current state of the player. 
	public var state: Player.State
	{
			return Player.State(rawValue: Int(linphone_player_get_state(cPtr).rawValue))!
	}

	/// Retrieve the user pointer associated with the player. 
	/// - Returns: The user pointer associated with the player. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_player_get_user_data(cPtr)
		}
		set
		{
			linphone_player_set_user_data(cPtr, newValue)
		}
	}
	///	Close the opened file. 
	public func close() 
	{
		linphone_player_close(cPtr)
	}
	///	Open a file for playing. 
	/// - Parameter filename: The path to the file to open 
	/// 
	public func open(filename:String) throws 
	{
		let exception_result = linphone_player_open(cPtr, filename)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "open returned value \(exception_result)")
		}
	}
	///	Pause the playing of a file. 
	/// - Returns: 0 on success, a negative value otherwise 
	public func pause() throws 
	{
		let exception_result = linphone_player_pause(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "pause returned value \(exception_result)")
		}
	}
	///	Seek in an opened file. 
	/// - Parameter timeMs: The time we want to go to in the file (in milliseconds). 
	/// 
	/// 
	/// - Returns: 0 on success, a negative value otherwise. 
	public func seek(timeMs:Int) throws 
	{
		let exception_result = linphone_player_seek(cPtr, CInt(timeMs))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "seek returned value \(exception_result)")
		}
	}
	///	Start playing a file that has been opened with {@link Player#open}. 
	/// - Returns: 0 on success, a negative value otherwise 
	public func start() throws 
	{
		let exception_result = linphone_player_start(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "start returned value \(exception_result)")
		}
	}
}

/// Presence activity type holding information about a presence activity. 
public class PresenceActivity : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> PresenceActivity {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PresenceActivity>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PresenceActivity(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Gets the description of a presence activity. 
	/// - Returns: A pointer to the description string of the presence activity, or nil
	/// if no description is specified. 
	public var description: String
	{
			return charArrayToString(charPointer: linphone_presence_activity_get_description(cPtr))
	}

	public func setDescription(newValue: String) throws
	{
		let exception_result = linphone_presence_activity_set_description(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the activity type of a presence activity. 
	/// - Returns: The LinphonePresenceActivityType of the activity. 
	public var type: PresenceActivityType
	{
			return PresenceActivityType(rawValue: Int(linphone_presence_activity_get_type(cPtr).rawValue))!
	}

	public func setType(newValue: PresenceActivityType) throws
	{
		let exception_result = linphone_presence_activity_set_type(cPtr, LinphonePresenceActivityType(rawValue: CUnsignedInt(newValue.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the user data of a `PresenceActivity` object. 
	/// - Returns: A pointer to the user data. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_presence_activity_get_user_data(cPtr)
		}
		set
		{
			linphone_presence_activity_set_user_data(cPtr, newValue)
		}
	}
	///	Gets the string representation of a presence activity. 
	/// - Returns: A pointer a dynamically allocated string representing the given
	/// activity.
	/// 
	/// The returned string is to be freed by calling ms_free(). 
	public func toString() -> String
	{
		return charArrayToString(charPointer: linphone_presence_activity_to_string(cPtr))
	}
}

/// Presence model type holding information about the presence of a person. 
public class PresenceModel : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> PresenceModel {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PresenceModel>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PresenceModel(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///	Creates a presence model specifying an activity. 
	/// - Parameter activity: The activity to set for the created presence model. 
	/// - Parameter description: An additional description of the activity (mainly
	/// useful for the 'other' activity). Set it to nil to not add a description. 
	/// 
	/// 
	/// - Returns: The created presence model, or nil if an error occured. 
	/// 
	/// - See also: linphone_presence_model_new 
	/// 
	/// - See also: linphone_presence_model_new_with_activity_and_note
	/// 
	/// The created presence model has the activity specified in the parameters. 
	static public func newWithActivity(activity:PresenceActivityType, description:String) -> PresenceModel?
	{
		let cPointer = linphone_presence_model_new_with_activity(LinphonePresenceActivityType(rawValue: CUnsignedInt(activity.rawValue)), description)
		if (cPointer == nil) {
			return nil
		}
		return PresenceModel.getSwiftObject(cObject: cPointer!)
	}
	///	Creates a presence model specifying an activity and adding a note. 
	/// - Parameter activity: The activity to set for the created presence model. 
	/// - Parameter description: An additional description of the activity (mainly
	/// useful for the 'other' activity). Set it to nil to not add a description. 
	/// - Parameter note: An additional note giving additional information about the
	/// contact presence. 
	/// - Parameter lang: The language the note is written in. It can be set to nil in
	/// order to not specify the language of the note. 
	/// 
	/// 
	/// - Returns: The created presence model, or nil if an error occured. 
	/// 
	/// - See also: linphone_presence_model_new_with_activity 
	/// 
	/// - See also: linphone_presence_model_new_with_activity_and_note
	/// 
	/// The created presence model has the activity and the note specified in the
	/// parameters. 
	static public func newWithActivityAndNote(activity:PresenceActivityType, description:String, note:String, lang:String) -> PresenceModel?
	{
		let cPointer = linphone_presence_model_new_with_activity_and_note(LinphonePresenceActivityType(rawValue: CUnsignedInt(activity.rawValue)), description, note, lang)
		if (cPointer == nil) {
			return nil
		}
		return PresenceModel.getSwiftObject(cObject: cPointer!)
	}

	/// Gets the first activity of a presence model (there is usually only one). 
	/// - Returns: A `PresenceActivity` object if successful, nil otherwise. 
	public var activity: PresenceActivity?
	{
			let cPointer = linphone_presence_model_get_activity(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return PresenceActivity.getSwiftObject(cObject:cPointer!)
	}

	/// Gets the basic status of a presence model. 
	/// - Returns: The LinphonePresenceBasicStatus of the `PresenceModel` object given
	/// as parameter. 
	public var basicStatus: PresenceBasicStatus
	{
			return PresenceBasicStatus(rawValue: Int(linphone_presence_model_get_basic_status(cPtr).rawValue))!
	}

	public func setBasicstatus(newValue: PresenceBasicStatus) throws
	{
		let exception_result = linphone_presence_model_set_basic_status(cPtr, LinphonePresenceBasicStatus(rawValue: CUnsignedInt(newValue.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the capabilities of a `PresenceModel` object. 
	/// - Returns: the capabilities. 
	public var capabilities: Int
	{
			return Int(linphone_presence_model_get_capabilities(cPtr))
	}

	/// Get the consolidated presence from a presence model. 
	/// - Returns: The LinphoneConsolidatedPresence corresponding to the presence model 
	public var consolidatedPresence: ConsolidatedPresence
	{
			return ConsolidatedPresence(rawValue: Int(linphone_presence_model_get_consolidated_presence(cPtr).rawValue))!
	}

	/// Gets the contact of a presence model. 
	/// - Returns: A pointer to a dynamically allocated string containing the contact,
	/// or nil if no contact is found.
	/// 
	/// The returned string is to be freed by calling ms_free(). 
	public var contact: String
	{
			return charArrayToString(charPointer: linphone_presence_model_get_contact(cPtr))
	}

	public func setContact(newValue: String) throws
	{
		let exception_result = linphone_presence_model_set_contact(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Tells whether a presence model is considered online. 
	/// It is any of theses cases:
	/// 
	public var isOnline: Bool
	{
			return linphone_presence_model_is_online(cPtr) != 0
	}

	/// Gets the number of activities included in the presence model. 
	/// - Returns: The number of activities included in the `PresenceModel` object. 
	public var nbActivities: UInt
	{
			return UInt(linphone_presence_model_get_nb_activities(cPtr))
	}

	/// Gets the number of persons included in the presence model. 
	/// - Returns: The number of persons included in the `PresenceModel` object. 
	public var nbPersons: UInt
	{
			return UInt(linphone_presence_model_get_nb_persons(cPtr))
	}

	/// Gets the number of services included in the presence model. 
	/// - Returns: The number of services included in the `PresenceModel` object. 
	public var nbServices: UInt
	{
			return UInt(linphone_presence_model_get_nb_services(cPtr))
	}

	/// Gets the presentity of a presence model. 
	/// - Returns: A pointer to a const LinphoneAddress, or nil if no contact is found. 
	public var presentity: Address?
	{
			let cPointer = linphone_presence_model_get_presentity(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	public func setPresentity(newValue: Address) throws
	{
		let exception_result = linphone_presence_model_set_presentity(cPtr, newValue.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the timestamp of a presence model. 
	/// - Returns: The timestamp of the `PresenceModel` object or -1 on error. 
	public var timestamp: time_t
	{
			return linphone_presence_model_get_timestamp(cPtr)
	}

	/// Gets the user data of a `PresenceModel` object. 
	/// - Returns: A pointer to the user data. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_presence_model_get_user_data(cPtr)
		}
		set
		{
			linphone_presence_model_set_user_data(cPtr, newValue)
		}
	}
	///	Adds an activity to a presence model. 
	/// - Parameter activity: The `PresenceActivity` object to add to the model. 
	/// 
	/// 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addActivity(activity:PresenceActivity) throws 
	{
		let exception_result = linphone_presence_model_add_activity(cPtr, activity.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addActivity returned value \(exception_result)")
		}
	}
	///	Adds a note to a presence model. 
	/// - Parameter noteContent: The note to be added to the presence model. 
	/// - Parameter lang: The language of the note to be added. Can be nil if no
	/// language is to be specified for the note. 
	/// 
	/// 
	/// - Returns: 0 if successful, a value < 0 in case of error.
	/// 
	/// Only one note for each language can be set, so e.g. setting a note for the 'fr'
	/// language if there is only one will replace the existing one. 
	public func addNote(noteContent:String, lang:String) throws 
	{
		let exception_result = linphone_presence_model_add_note(cPtr, noteContent, lang)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addNote returned value \(exception_result)")
		}
	}
	///	Adds a person to a presence model. 
	/// - Parameter person: The `PresencePerson` object to add to the model. 
	/// 
	/// 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addPerson(person:PresencePerson) throws 
	{
		let exception_result = linphone_presence_model_add_person(cPtr, person.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addPerson returned value \(exception_result)")
		}
	}
	///	Adds a service to a presence model. 
	/// - Parameter service: The `PresenceService` object to add to the model. 
	/// 
	/// 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addService(service:PresenceService) throws 
	{
		let exception_result = linphone_presence_model_add_service(cPtr, service.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addService returned value \(exception_result)")
		}
	}
	///	Clears the activities of a presence model. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearActivities() throws 
	{
		let exception_result = linphone_presence_model_clear_activities(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearActivities returned value \(exception_result)")
		}
	}
	///	Clears all the notes of a presence model. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearNotes() throws 
	{
		let exception_result = linphone_presence_model_clear_notes(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearNotes returned value \(exception_result)")
		}
	}
	///	Clears the persons of a presence model. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearPersons() throws 
	{
		let exception_result = linphone_presence_model_clear_persons(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearPersons returned value \(exception_result)")
		}
	}
	///	Clears the services of a presence model. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearServices() throws 
	{
		let exception_result = linphone_presence_model_clear_services(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearServices returned value \(exception_result)")
		}
	}
	///	Returns the version of the capability of a `PresenceModel`. 
	/// - Parameter capability: The capability to test. 
	/// 
	/// 
	/// - Returns: the version of the capability of a `PresenceModel` or -1.0 if the
	/// model has not the capability. 
	public func getCapabilityVersion(capability:FriendCapability) -> Float
	{
		return linphone_presence_model_get_capability_version(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue)))
	}
	///	Gets the first note of a presence model (there is usually only one). 
	/// - Parameter lang: The language of the note to get. Can be nil to get a note
	/// that has no language specified or to get the first note whatever language it is
	/// written into. 
	/// 
	/// 
	/// - Returns: A pointer to a `PresenceNote` object if successful, nil otherwise. 
	public func getNote(lang:String) -> PresenceNote?
	{
		let cPointer = linphone_presence_model_get_note(cPtr, lang)
		if (cPointer == nil) {
			return nil
		}
		return PresenceNote.getSwiftObject(cObject: cPointer!)
	}
	///	Gets the nth activity of a presence model. 
	/// - Parameter idx: The index of the activity to get (the first activity having
	/// the index 0). 
	/// 
	/// 
	/// - Returns: A pointer to a `PresenceActivity` object if successful, nil
	/// otherwise. 
	public func getNthActivity(idx:UInt) -> PresenceActivity?
	{
		let cPointer = linphone_presence_model_get_nth_activity(cPtr, CUnsignedInt(idx))
		if (cPointer == nil) {
			return nil
		}
		return PresenceActivity.getSwiftObject(cObject: cPointer!)
	}
	///	Gets the nth person of a presence model. 
	/// - Parameter idx: The index of the person to get (the first person having the
	/// index 0). 
	/// 
	/// 
	/// - Returns: A pointer to a `PresencePerson` object if successful, nil otherwise. 
	public func getNthPerson(idx:UInt) -> PresencePerson?
	{
		let cPointer = linphone_presence_model_get_nth_person(cPtr, CUnsignedInt(idx))
		if (cPointer == nil) {
			return nil
		}
		return PresencePerson.getSwiftObject(cObject: cPointer!)
	}
	///	Gets the nth service of a presence model. 
	/// - Parameter idx: The index of the service to get (the first service having the
	/// index 0). 
	/// 
	/// 
	/// - Returns: A pointer to a `PresenceService` object if successful, nil
	/// otherwise. 
	public func getNthService(idx:UInt) -> PresenceService?
	{
		let cPointer = linphone_presence_model_get_nth_service(cPtr, CUnsignedInt(idx))
		if (cPointer == nil) {
			return nil
		}
		return PresenceService.getSwiftObject(cObject: cPointer!)
	}
	///	Returns whether or not the `PresenceModel` object has a given capability. 
	/// - Parameter capability: The capability to test. 
	/// 
	/// 
	/// - Returns: whether or not the `PresenceModel` object has a given capability. 
	public func hasCapability(capability:FriendCapability) -> Bool
	{
		return linphone_presence_model_has_capability(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue))) != 0
	}
	///	Returns whether or not the `PresenceModel` object has a given capability with a
	///	certain version. 
	/// - Parameter capability: The capability to test. 
	/// - Parameter version: The wanted version to test. 
	/// 
	/// 
	/// - Returns: whether or not the `PresenceModel` object has a given capability
	/// with a certain version. 
	public func hasCapabilityWithVersion(capability:FriendCapability, version:Float) -> Bool
	{
		return linphone_presence_model_has_capability_with_version(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue)), version) != 0
	}
	///	Returns whether or not the `PresenceModel` object has a given capability with a
	///	certain version or more. 
	/// - Parameter capability: The capability to test. 
	/// - Parameter version: The wanted version to test. 
	/// 
	/// 
	/// - Returns: whether or not the `PresenceModel` object has a given capability
	/// with a certain version or more. 
	public func hasCapabilityWithVersionOrMore(capability:FriendCapability, version:Float) -> Bool
	{
		return linphone_presence_model_has_capability_with_version_or_more(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue)), version) != 0
	}
	///	Sets the activity of a presence model (limits to only one activity). 
	/// - Parameter activity: The LinphonePresenceActivityType to set for the model. 
	/// - Parameter description: An additional description of the activity to set for
	/// the model. Can be nil if no additional description is to be added. 
	/// 
	/// 
	/// - Returns: 0 if successful, a value < 0 in case of error.
	/// 
	/// WARNING: This function will modify the basic status of the model according to
	/// the activity being set. If you don't want the basic status to be modified
	/// automatically, you can use the combination of {@link
	/// PresenceModel#setBasicStatus}, {@link PresenceModel#clearActivities} and {@link
	/// PresenceModel#addActivity}. 
	public func setActivity(activity:PresenceActivityType, description:String) throws 
	{
		let exception_result = linphone_presence_model_set_activity(cPtr, LinphonePresenceActivityType(rawValue: CUnsignedInt(activity.rawValue)), description)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "setActivity returned value \(exception_result)")
		}
	}
}

/// Presence note type holding information about a presence note. 
public class PresenceNote : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> PresenceNote {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PresenceNote>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PresenceNote(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Gets the content of a presence note. 
	/// - Returns: A pointer to the content of the presence note. 
	public var content: String
	{
			return charArrayToString(charPointer: linphone_presence_note_get_content(cPtr))
	}

	public func setContent(newValue: String) throws
	{
		let exception_result = linphone_presence_note_set_content(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the language of a presence note. 
	/// - Returns: A pointer to the language string of the presence note, or nil if no
	/// language is specified. 
	public var lang: String
	{
			return charArrayToString(charPointer: linphone_presence_note_get_lang(cPtr))
	}

	public func setLang(newValue: String) throws
	{
		let exception_result = linphone_presence_note_set_lang(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the user data of a `PresenceNote` object. 
	/// - Returns: A pointer to the user data. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_presence_note_get_user_data(cPtr)
		}
		set
		{
			linphone_presence_note_set_user_data(cPtr, newValue)
		}
	}
}

/// Presence person holding information about a presence person. 
public class PresencePerson : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> PresencePerson {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PresencePerson>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PresencePerson(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Gets the id of a presence person. 
	/// - Returns: A pointer to a dynamically allocated string containing the id, or
	/// nil in case of error.
	/// 
	/// The returned string is to be freed by calling ms_free(). 
	public var id: String
	{
			return charArrayToString(charPointer: linphone_presence_person_get_id(cPtr))
	}

	public func setId(newValue: String) throws
	{
		let exception_result = linphone_presence_person_set_id(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the number of activities included in the presence person. 
	/// - Returns: The number of activities included in the `PresencePerson` object. 
	public var nbActivities: UInt
	{
			return UInt(linphone_presence_person_get_nb_activities(cPtr))
	}

	/// Gets the number of activities notes included in the presence person. 
	/// - Returns: The number of activities notes included in the `PresencePerson`
	/// object. 
	public var nbActivitiesNotes: UInt
	{
			return UInt(linphone_presence_person_get_nb_activities_notes(cPtr))
	}

	/// Gets the number of notes included in the presence person. 
	/// - Returns: The number of notes included in the `PresencePerson` object. 
	public var nbNotes: UInt
	{
			return UInt(linphone_presence_person_get_nb_notes(cPtr))
	}

	/// Gets the user data of a `PresencePerson` object. 
	/// - Returns: A pointer to the user data. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_presence_person_get_user_data(cPtr)
		}
		set
		{
			linphone_presence_person_set_user_data(cPtr, newValue)
		}
	}
	///	Adds an activities note to a presence person. 
	/// - Parameter note: The `PresenceNote` object to add to the person. 
	/// 
	/// 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addActivitiesNote(note:PresenceNote) throws 
	{
		let exception_result = linphone_presence_person_add_activities_note(cPtr, note.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addActivitiesNote returned value \(exception_result)")
		}
	}
	///	Adds an activity to a presence person. 
	/// - Parameter activity: The `PresenceActivity` object to add to the person. 
	/// 
	/// 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addActivity(activity:PresenceActivity) throws 
	{
		let exception_result = linphone_presence_person_add_activity(cPtr, activity.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addActivity returned value \(exception_result)")
		}
	}
	///	Adds a note to a presence person. 
	/// - Parameter note: The `PresenceNote` object to add to the person. 
	/// 
	/// 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addNote(note:PresenceNote) throws 
	{
		let exception_result = linphone_presence_person_add_note(cPtr, note.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addNote returned value \(exception_result)")
		}
	}
	///	Clears the activities of a presence person. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearActivities() throws 
	{
		let exception_result = linphone_presence_person_clear_activities(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearActivities returned value \(exception_result)")
		}
	}
	///	Clears the activities notes of a presence person. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearActivitiesNotes() throws 
	{
		let exception_result = linphone_presence_person_clear_activities_notes(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearActivitiesNotes returned value \(exception_result)")
		}
	}
	///	Clears the notes of a presence person. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearNotes() throws 
	{
		let exception_result = linphone_presence_person_clear_notes(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearNotes returned value \(exception_result)")
		}
	}
	///	Gets the nth activities note of a presence person. 
	/// - Parameter idx: The index of the activities note to get (the first note having
	/// the index 0). 
	/// 
	/// 
	/// - Returns: A pointer to a `PresenceNote` object if successful, nil otherwise. 
	public func getNthActivitiesNote(idx:UInt) -> PresenceNote?
	{
		let cPointer = linphone_presence_person_get_nth_activities_note(cPtr, CUnsignedInt(idx))
		if (cPointer == nil) {
			return nil
		}
		return PresenceNote.getSwiftObject(cObject: cPointer!)
	}
	///	Gets the nth activity of a presence person. 
	/// - Parameter idx: The index of the activity to get (the first activity having
	/// the index 0). 
	/// 
	/// 
	/// - Returns: A pointer to a `PresenceActivity` object if successful, nil
	/// otherwise. 
	public func getNthActivity(idx:UInt) -> PresenceActivity?
	{
		let cPointer = linphone_presence_person_get_nth_activity(cPtr, CUnsignedInt(idx))
		if (cPointer == nil) {
			return nil
		}
		return PresenceActivity.getSwiftObject(cObject: cPointer!)
	}
	///	Gets the nth note of a presence person. 
	/// - Parameter idx: The index of the note to get (the first note having the index
	/// 0). 
	/// 
	/// 
	/// - Returns: A pointer to a `PresenceNote` object if successful, nil otherwise. 
	public func getNthNote(idx:UInt) -> PresenceNote?
	{
		let cPointer = linphone_presence_person_get_nth_note(cPtr, CUnsignedInt(idx))
		if (cPointer == nil) {
			return nil
		}
		return PresenceNote.getSwiftObject(cObject: cPointer!)
	}
}

/// Presence service type holding information about a presence service. 
public class PresenceService : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> PresenceService {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PresenceService>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PresenceService(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Gets the basic status of a presence service. 
	/// - Returns: The LinphonePresenceBasicStatus of the `PresenceService` object
	/// given as parameter. 
	public var basicStatus: PresenceBasicStatus
	{
			return PresenceBasicStatus(rawValue: Int(linphone_presence_service_get_basic_status(cPtr).rawValue))!
	}

	public func setBasicstatus(newValue: PresenceBasicStatus) throws
	{
		let exception_result = linphone_presence_service_set_basic_status(cPtr, LinphonePresenceBasicStatus(rawValue: CUnsignedInt(newValue.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the contact of a presence service. 
	/// - Returns: A pointer to a dynamically allocated string containing the contact,
	/// or nil if no contact is found.
	/// 
	/// The returned string is to be freed by calling ms_free(). 
	public var contact: String
	{
			return charArrayToString(charPointer: linphone_presence_service_get_contact(cPtr))
	}

	public func setContact(newValue: String) throws
	{
		let exception_result = linphone_presence_service_set_contact(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the id of a presence service. 
	/// - Returns: A pointer to a dynamically allocated string containing the id, or
	/// nil in case of error.
	/// 
	/// The returned string is to be freed by calling ms_free(). 
	public var id: String
	{
			return charArrayToString(charPointer: linphone_presence_service_get_id(cPtr))
	}

	public func setId(newValue: String) throws
	{
		let exception_result = linphone_presence_service_set_id(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the number of notes included in the presence service. 
	/// - Returns: The number of notes included in the `PresenceService` object. 
	public var nbNotes: UInt
	{
			return UInt(linphone_presence_service_get_nb_notes(cPtr))
	}

	/// Gets the service descriptions of a presence service. 
	/// - Returns: A A list of char * objects. char *  containing the services
	/// descriptions.
	/// 
	/// The returned string is to be freed. 
	public var serviceDescriptions: [String]
	{
			var swiftList = [String]()
			var cList = linphone_presence_service_get_service_descriptions(cPtr)
			while (cList != nil) {
				swiftList.append(String(cString: unsafeBitCast(cList!.pointee.data, to: UnsafePointer<CChar>.self)))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList!.pointee.next)
			}
			return swiftList
	}

	public func setServicedescriptions(newValue: [String]) throws
	{
		var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
		for data in newValue {
			let sData:NSString = data as NSString
			cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
		}
		let exception_result = linphone_presence_service_set_service_descriptions(cPtr, cList)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the user data of a `PresenceService` object. 
	/// - Returns: A pointer to the user data. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_presence_service_get_user_data(cPtr)
		}
		set
		{
			linphone_presence_service_set_user_data(cPtr, newValue)
		}
	}
	///	Adds a note to a presence service. 
	/// - Parameter note: The `PresenceNote` object to add to the service. 
	/// 
	/// 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addNote(note:PresenceNote) throws 
	{
		let exception_result = linphone_presence_service_add_note(cPtr, note.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addNote returned value \(exception_result)")
		}
	}
	///	Clears the notes of a presence service. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearNotes() throws 
	{
		let exception_result = linphone_presence_service_clear_notes(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearNotes returned value \(exception_result)")
		}
	}
	///	Gets the nth note of a presence service. 
	/// - Parameter idx: The index of the note to get (the first note having the index
	/// 0). 
	/// 
	/// 
	/// - Returns: A pointer to a `PresenceNote` object if successful, nil otherwise. 
	public func getNthNote(idx:UInt) -> PresenceNote?
	{
		let cPointer = linphone_presence_service_get_nth_note(cPtr, CUnsignedInt(idx))
		if (cPointer == nil) {
			return nil
		}
		return PresenceNote.getSwiftObject(cObject: cPointer!)
	}
}

/// The `ProxyConfig` object represents a proxy configuration to be used by the
/// `Core` object. 
/// Its fields must not be used directly in favour of the accessors methods. Once
/// created and filled properly the `ProxyConfig` can be given to `Core` with
/// {@link Core#addProxyConfig}. This will automatically triggers the registration,
/// if enabled.
/// 
/// The proxy configuration are persistent to restarts because they are saved in
/// the configuration file. As a consequence, after linphone_core_new there might
/// already be a list of configured proxy that can be examined with {@link
/// Core#getProxyConfigList}.
/// 
/// The default proxy (see linphone_core_set_default_proxy ) is the one of the list
/// that is used by default for calls. 
public class ProxyConfig : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> ProxyConfig {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ProxyConfig>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ProxyConfig(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Indicates whether AVPF/SAVPF is being used for calls using this proxy config. 
	/// - Returns: True if AVPF/SAVPF is enabled, false otherwise. 
	public var avpfEnabled: Bool
	{
			return linphone_proxy_config_avpf_enabled(cPtr) != 0
	}

	/// Get enablement status of RTCP feedback (also known as AVPF profile). 
	/// - Returns: the enablement mode, which can be LinphoneAVPFDefault (use
	/// LinphoneCore's mode), LinphoneAVPFEnabled (avpf is enabled), or
	/// LinphoneAVPFDisabled (disabled). 
	public var avpfMode: AVPFMode
	{
		get
		{
			return AVPFMode(rawValue: Int(linphone_proxy_config_get_avpf_mode(cPtr).rawValue))!
		}
		set
		{
			linphone_proxy_config_set_avpf_mode(cPtr, LinphoneAVPFMode(rawValue: CInt(newValue.rawValue)))
		}
	}

	/// Get the interval between regular RTCP reports when using AVPF/SAVPF. 
	/// - Returns: The interval in seconds. 
	public var avpfRrInterval: UInt8
	{
		get
		{
			return linphone_proxy_config_get_avpf_rr_interval(cPtr)
		}
		set
		{
			linphone_proxy_config_set_avpf_rr_interval(cPtr, newValue)
		}
	}

	/// Get the conference factory uri. 
	/// - Returns: The uri of the conference factory 
	public var conferenceFactoryUri: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_proxy_config_get_conference_factory_uri(cPtr))
		}
		set
		{
			linphone_proxy_config_set_conference_factory_uri(cPtr, newValue)
		}
	}

	/// Return the contact address of the proxy config. 
	/// - Returns: a `Address` correspong to the contact address of the proxy config. 
	public var contact: Address?
	{
			let cPointer = linphone_proxy_config_get_contact(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// - Returns: previously set contact parameters. 
	public var contactParameters: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_proxy_config_get_contact_parameters(cPtr))
		}
		set
		{
			linphone_proxy_config_set_contact_parameters(cPtr, newValue)
		}
	}

	/// - Returns: previously set contact URI parameters. 
	public var contactUriParameters: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_proxy_config_get_contact_uri_parameters(cPtr))
		}
		set
		{
			linphone_proxy_config_set_contact_uri_parameters(cPtr, newValue)
		}
	}

	/// Get the `Core` object to which is associated the `ProxyConfig`. 
	/// - Returns: The `Core` object to which is associated the `ProxyConfig`. 
	public var core: Core?
	{
			let cPointer = linphone_proxy_config_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Core.getSwiftObject(cObject:cPointer!)
	}

	/// Get the dependency of a `ProxyConfig`. 
	/// - Returns: The proxy config this one is dependent upon, or nil if not marked
	/// dependent 
	public var dependency: ProxyConfig?
	{
		get
		{
			let cPointer = linphone_proxy_config_get_dependency(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ProxyConfig.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_proxy_config_set_dependency(cPtr, newValue?.cPtr)
		}
	}

	/// - Returns: whether liblinphone should replace "+" by "00" in dialed numbers
	/// (passed to linphone_core_invite ). 
	public var dialEscapePlus: Bool
	{
		get
		{
			return linphone_proxy_config_get_dial_escape_plus(cPtr) != 0
		}
		set
		{
			linphone_proxy_config_set_dial_escape_plus(cPtr, newValue==true ? 1:0)
		}
	}

	/// - Returns: dialing prefix. 
	public var dialPrefix: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_proxy_config_get_dial_prefix(cPtr))
		}
		set
		{
			linphone_proxy_config_set_dial_prefix(cPtr, newValue)
		}
	}

	/// Get the domain name of the given proxy config. 
	/// - Returns: The domain name of the proxy config. 
	public var domain: String
	{
			return charArrayToString(charPointer: linphone_proxy_config_get_domain(cPtr))
	}

	/// Get the reason why registration failed when the proxy config state is
	/// LinphoneRegistrationFailed. 
	/// - Returns: The reason why registration failed for this proxy config. 
	public var error: Reason
	{
			return Reason(rawValue: Int(linphone_proxy_config_get_error(cPtr).rawValue))!
	}

	/// Get detailed information why registration failed when the proxy config state is
	/// LinphoneRegistrationFailed. 
	/// - Returns: The details why registration failed for this proxy config. 
	public var errorInfo: ErrorInfo?
	{
			let cPointer = linphone_proxy_config_get_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return ErrorInfo.getSwiftObject(cObject:cPointer!)
	}

	/// - Returns: the duration of registration. 
	public var expires: Int
	{
		get
		{
			return Int(linphone_proxy_config_get_expires(cPtr))
		}
		set
		{
			linphone_proxy_config_set_expires(cPtr, CInt(newValue))
		}
	}

	/// - Returns: the SIP identity that belongs to this proxy configuration. 
	public var identityAddress: Address?
	{
			let cPointer = linphone_proxy_config_get_identity_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	public func setIdentityaddress(newValue: Address) throws
	{
		let exception_result = linphone_proxy_config_set_identity_address(cPtr, newValue.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the idkey property of a `ProxyConfig`. 
	/// - Returns: The idkey string, or nil 
	public var idkey: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_proxy_config_get_idkey(cPtr))
		}
		set
		{
			linphone_proxy_config_set_idkey(cPtr, newValue)
		}
	}

	/// Indicates whether to add to the contact parameters the push notification
	/// information. 
	/// - Returns: True if push notification informations should be added, false
	/// otherwise. 
	public var isPushNotificationAllowed: Bool
	{
			return linphone_proxy_config_is_push_notification_allowed(cPtr) != 0
	}

	/// Get The policy that is used to pass through NATs/firewalls when using this
	/// proxy config. 
	/// If it is set to nil, the default NAT policy from the core will be used instead. 
	/// 
	/// - Returns: `NatPolicy` object in use. 
	/// 
	/// - See also: {@link Core#getNatPolicy} 
	public var natPolicy: NatPolicy?
	{
		get
		{
			let cPointer = linphone_proxy_config_get_nat_policy(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return NatPolicy.getSwiftObject(cObject:cPointer!)
		}
		set
		{
			linphone_proxy_config_set_nat_policy(cPtr, newValue?.cPtr)
		}
	}

	/// Get default privacy policy for all calls routed through this proxy. 
	/// - Returns: Privacy mode 
	public var privacy: UInt
	{
		get
		{
			return UInt(linphone_proxy_config_get_privacy(cPtr))
		}
		set
		{
			linphone_proxy_config_set_privacy(cPtr, CUnsignedInt(newValue))
		}
	}

	/// - Returns:  if PUBLISH request is enabled for this proxy. 
	public var publishEnabled: Bool
	{
		get
		{
			return linphone_proxy_config_publish_enabled(cPtr) != 0
		}
		set
		{
			linphone_proxy_config_enable_publish(cPtr, newValue==true ? 1:0)
		}
	}

	/// get the publish expiration time in second. 
	/// Default value is the registration expiration value. 
	/// 
	/// - Returns: expires in second 
	public var publishExpires: Int
	{
		get
		{
			return Int(linphone_proxy_config_get_publish_expires(cPtr))
		}
		set
		{
			linphone_proxy_config_set_publish_expires(cPtr, CInt(newValue))
		}
	}

	/// Indicates whether to add to the contact parameters the push notification
	/// information. 
	/// - Parameter allow: True to allow push notification information, false
	/// otherwise. 
	/// 
	public var pushNotificationAllowed: Bool?
	{
		willSet
		{
			linphone_proxy_config_set_push_notification_allowed(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the route of the collector end-point when using quality reporting. 
	/// This SIP address should be used on server-side to process packets directly
	/// before discarding packets. Collector address should be a non existing account
	/// and will not receive any messages. If nil, reports will be send to the proxy
	/// domain. 
	/// 
	/// - Returns: The SIP address of the collector end-point. 
	public var qualityReportingCollector: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_proxy_config_get_quality_reporting_collector(cPtr))
		}
		set
		{
			linphone_proxy_config_set_quality_reporting_collector(cPtr, newValue)
		}
	}

	/// Indicates whether quality statistics during call should be stored and sent to a
	/// collector according to RFC 6035. 
	/// - Returns: True if quality repotring is enabled, false otherwise. 
	public var qualityReportingEnabled: Bool
	{
		get
		{
			return linphone_proxy_config_quality_reporting_enabled(cPtr) != 0
		}
		set
		{
			linphone_proxy_config_enable_quality_reporting(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the interval between interval reports when using quality reporting. 
	/// - Returns: The interval in seconds, 0 means interval reports are disabled. 
	public var qualityReportingInterval: Int
	{
		get
		{
			return Int(linphone_proxy_config_get_quality_reporting_interval(cPtr))
		}
		set
		{
			linphone_proxy_config_set_quality_reporting_interval(cPtr, CInt(newValue))
		}
	}

	/// Get the realm of the given proxy config. 
	/// - Returns: The realm of the proxy config. 
	public var realm: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_proxy_config_get_realm(cPtr))
		}
		set
		{
			linphone_proxy_config_set_realm(cPtr, newValue)
		}
	}

	/// Get the persistent reference key associated to the proxy config. 
	/// The reference key can be for example an id to an external database. It is
	/// stored in the config file, thus can survive to process exits/restarts.
	/// 
	/// - Returns: The reference key string that has been associated to the proxy
	/// config, or nil if none has been associated. 
	public var refKey: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_proxy_config_get_ref_key(cPtr))
		}
		set
		{
			linphone_proxy_config_set_ref_key(cPtr, newValue)
		}
	}

	/// - Returns:  if registration to the proxy is enabled. 
	public var registerEnabled: Bool
	{
		get
		{
			return linphone_proxy_config_register_enabled(cPtr) != 0
		}
		set
		{
			linphone_proxy_config_enable_register(cPtr, newValue==true ? 1:0)
		}
	}

	/// - Returns: the route set for this proxy configuration. 
	/// 
	/// - deprecated: Use {@link ProxyConfig#getRoutes} instead. 
	public var route: String
	{
			return charArrayToString(charPointer: linphone_proxy_config_get_route(cPtr))
	}

	public func setRoute(newValue: String) throws
	{
		let exception_result = linphone_proxy_config_set_route(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the list of the routes set for this proxy config. 
	/// - Returns: A list of const char * objects. const char *  the list of routes. 
	public var routes: [String]
	{
			var swiftList = [String]()
			var cList = linphone_proxy_config_get_routes(cPtr)
			while (cList != nil) {
				swiftList.append(String(cString: unsafeBitCast(cList!.pointee.data, to: UnsafePointer<CChar>.self)))
				cList = UnsafePointer<bctbx_list_t>(cList!.pointee.next)
			}
			return swiftList
	}

	public func setRoutes(newValue: [String]) throws
	{
		var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
		for data in newValue {
			let sData:NSString = data as NSString
			cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
		}
		let exception_result = linphone_proxy_config_set_routes(cPtr, cList)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// - Returns: the proxy's SIP address. 
	public var serverAddr: String
	{
			return charArrayToString(charPointer: linphone_proxy_config_get_server_addr(cPtr))
	}

	public func setServeraddr(newValue: String) throws
	{
		let exception_result = linphone_proxy_config_set_server_addr(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the registration state of the given proxy config. 
	/// - Returns: The registration state of the proxy config. 
	public var state: RegistrationState
	{
			return RegistrationState(rawValue: Int(linphone_proxy_config_get_state(cPtr).rawValue))!
	}

	/// Get the transport from either service route, route or addr. 
	/// - Returns: The transport as a string (I.E udp, tcp, tls, dtls) 
	public var transport: String
	{
			return charArrayToString(charPointer: linphone_proxy_config_get_transport(cPtr))
	}

	/// Return the unread chat message count for a given proxy config. 
	/// - Returns: The unread chat message count. 
	public var unreadChatMessageCount: Int
	{
			return Int(linphone_proxy_config_get_unread_chat_message_count(cPtr))
	}

	/// Retrieve the user pointer associated with the proxy config. 
	/// - Returns: The user pointer associated with the proxy config. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_proxy_config_get_user_data(cPtr)
		}
		set
		{
			linphone_proxy_config_set_user_data(cPtr, newValue)
		}
	}
	///	Commits modification made to the proxy configuration. 
	public func done() throws 
	{
		let exception_result = linphone_proxy_config_done(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "done returned value \(exception_result)")
		}
	}
	///	Starts editing a proxy configuration. 
	/// Because proxy configuration must be consistent, applications MUST call {@link
	/// ProxyConfig#edit} before doing any attempts to modify proxy configuration (such
	/// as identity, proxy address and so on). Once the modifications are done, then
	/// the application must call {@link ProxyConfig#done} to commit the changes. 
	public func edit() 
	{
		linphone_proxy_config_edit(cPtr)
	}
	///	Find authentication info matching proxy config, if any, similarly to
	///	linphone_core_find_auth_info. 
	/// - Returns: a `AuthInfo` matching proxy config criteria if possible, nil if
	/// nothing can be found. 
	public func findAuthInfo() -> AuthInfo?
	{
		let cPointer = linphone_proxy_config_find_auth_info(cPtr)
		if (cPointer == nil) {
			return nil
		}
		return AuthInfo.getSwiftObject(cObject: cPointer!)
	}
	///	Obtain the value of a header sent by the server in last answer to REGISTER. 
	/// - Parameter headerName: the header name for which to fetch corresponding value 
	/// 
	/// 
	/// - Returns: the value of the queried header. 
	public func getCustomHeader(headerName:String) -> String
	{
		return charArrayToString(charPointer: linphone_proxy_config_get_custom_header(cPtr, headerName))
	}
	///	Detect if the given input is a phone number or not. 
	/// - Parameter username: string to parse. 
	/// 
	/// 
	/// - Returns:  if input is a phone number, true otherwise. 
	public func isPhoneNumber(username:String) -> Bool
	{
		return linphone_proxy_config_is_phone_number(cPtr, username) != 0
	}
	///	Normalize a human readable phone number into a basic string. 
	/// 888-444-222 becomes 888444222 or +33888444222 depending on the `ProxyConfig`
	/// object. This function will always generate a normalized username if input is a
	/// phone number. 
	/// 
	/// - Parameter username: the string to parse 
	/// 
	/// 
	/// - Returns:  if input is an invalid phone number, normalized phone number from
	/// username input otherwise. 
	public func normalizePhoneNumber(username:String) -> String
	{
		return charArrayToString(charPointer: linphone_proxy_config_normalize_phone_number(cPtr, username))
	}
	///	Normalize a human readable sip uri into a fully qualified LinphoneAddress. 
	/// A sip address should look like DisplayName <sip:username@domain:port> .
	/// Basically this function performs the following tasks
	/// 
	/// 
	/// The result is a syntactically correct SIP address. 
	/// 
	/// - Parameter username: the string to parse 
	/// 
	/// 
	/// - Returns:  if invalid input, normalized sip address otherwise. 
	public func normalizeSipUri(username:String) -> Address?
	{
		let cPointer = linphone_proxy_config_normalize_sip_uri(cPtr, username)
		if (cPointer == nil) {
			return nil
		}
		return Address.getSwiftObject(cObject: cPointer!)
	}
	///	Prevent a proxy config from refreshing its registration. 
	/// This is useful to let registrations to expire naturally (or) when the
	/// application wants to keep control on when refreshes are sent. However,
	/// linphone_core_set_network_reachable(lc,true) will always request the proxy
	/// configs to refresh their registrations. The refreshing operations can be
	/// resumed with {@link ProxyConfig#refreshRegister}. 
	public func pauseRegister() 
	{
		linphone_proxy_config_pause_register(cPtr)
	}
	///	Refresh a proxy registration. 
	/// This is useful if for example you resuming from suspend, thus IP address may
	/// have changed. 
	public func refreshRegister() 
	{
		linphone_proxy_config_refresh_register(cPtr)
	}
	///	Set the value of a custom header sent to the server in REGISTERs request. 
	/// - Parameter headerName: the header name 
	/// - Parameter headerValue: the header's value 
	/// 
	public func setCustomHeader(headerName:String, headerValue:String) 
	{
		linphone_proxy_config_set_custom_header(cPtr, headerName, headerValue)
	}
}

/// Object holding chat message data received by a push notification. 
public class PushNotificationMessage : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> PushNotificationMessage {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PushNotificationMessage>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PushNotificationMessage(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Gets the call_id. 
	/// - Returns: The call_id. 
	public var callId: String
	{
			return charArrayToString(charPointer: linphone_push_notification_message_get_call_id(cPtr))
	}

	/// Gets the from_addr. 
	/// - Returns: The from_addr. 
	public var fromAddr: Address?
	{
			let cPointer = linphone_push_notification_message_get_from_addr(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// return true if it is a text message. 
	/// - Returns: The is_text. 
	public var isText: Bool
	{
			return linphone_push_notification_message_is_text(cPtr) != 0
	}

	/// is `PushNotificationMessage` build from UserDefaults data or from a
	/// `ChatMessage` 
	/// - Returns: The is_using_user_defaults. 
	public var isUsingUserDefaults: Bool
	{
			return linphone_push_notification_message_is_using_user_defaults(cPtr) != 0
	}

	/// Gets the local_addr. 
	/// - Returns: The local_addr. 
	public var localAddr: Address?
	{
			let cPointer = linphone_push_notification_message_get_local_addr(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Gets the peer_addr. 
	/// - Returns: The peer_addr. 
	public var peerAddr: Address?
	{
			let cPointer = linphone_push_notification_message_get_peer_addr(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// Gets the subject. 
	/// - Returns: The subject. 
	public var subject: String
	{
			return charArrayToString(charPointer: linphone_push_notification_message_get_subject(cPtr))
	}

	/// Gets the text content. 
	/// - Returns: The text_content. 
	public var textContent: String
	{
			return charArrayToString(charPointer: linphone_push_notification_message_get_text_content(cPtr))
	}
}

/// Structure describing a range of integers. 
public class Range : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Range {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Range>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Range(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Gets the higher value of the range. 
	/// - Returns: The higher value 
	public var max: Int
	{
		get
		{
			return Int(linphone_range_get_max(cPtr))
		}
		set
		{
			linphone_range_set_max(cPtr, CInt(newValue))
		}
	}

	/// Gets the lower value of the range. 
	/// - Returns: The lower value 
	public var min: Int
	{
		get
		{
			return Int(linphone_range_get_min(cPtr))
		}
		set
		{
			linphone_range_set_min(cPtr, CInt(newValue))
		}
	}

	/// Gets the user data in the `Range` object. 
	/// - Returns: the user data 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_range_get_user_data(cPtr)
		}
		set
		{
			linphone_range_set_user_data(cPtr, newValue)
		}
	}
}

/// The LinphoneSearchResult object represents a result of a search. 
public class SearchResult : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> SearchResult {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<SearchResult>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = SearchResult(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// - Returns: LinphoneAddress associed 
	public var address: Address?
	{
			let cPointer = linphone_search_result_get_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Address.getSwiftObject(cObject:cPointer!)
	}

	/// - Returns: the capabilities associated to the search result 
	public var capabilities: Int
	{
			return Int(linphone_search_result_get_capabilities(cPtr))
	}

	/// - Returns: LinphoneFriend associed 
	public var friend: Friend?
	{
			let cPointer = linphone_search_result_get_friend(cPtr)
			if (cPointer == nil) {
				return nil
			}
			return Friend.getSwiftObject(cObject:cPointer!)
	}

	/// - Returns: Phone Number associed 
	public var phoneNumber: String
	{
			return charArrayToString(charPointer: linphone_search_result_get_phone_number(cPtr))
	}

	/// - Returns: the result weight 
	public var weight: UInt
	{
			return UInt(linphone_search_result_get_weight(cPtr))
	}
	/// - Returns: whether a search result has a given capability 
	public func hasCapability(capability:FriendCapability) -> Bool
	{
		return linphone_search_result_has_capability(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue))) != 0
	}
}

/// Linphone core SIP transport ports. 
/// Special values LC_SIP_TRANSPORT_RANDOM, LC_SIP_TRANSPORT_RANDOM,
/// LC_SIP_TRANSPORT_DONTBIND can be used. Use with
/// linphone_core_set_sip_transports 
public class Transports : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Transports {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Transports>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Transports(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Gets the DTLS port in the `Transports` object. 
	/// - Returns: the DTLS port 
	public var dtlsPort: Int
	{
		get
		{
			return Int(linphone_transports_get_dtls_port(cPtr))
		}
		set
		{
			linphone_transports_set_dtls_port(cPtr, CInt(newValue))
		}
	}

	/// Gets the TCP port in the `Transports` object. 
	/// - Returns: the TCP port 
	public var tcpPort: Int
	{
		get
		{
			return Int(linphone_transports_get_tcp_port(cPtr))
		}
		set
		{
			linphone_transports_set_tcp_port(cPtr, CInt(newValue))
		}
	}

	/// Gets the TLS port in the `Transports` object. 
	/// - Returns: the TLS port 
	public var tlsPort: Int
	{
		get
		{
			return Int(linphone_transports_get_tls_port(cPtr))
		}
		set
		{
			linphone_transports_set_tls_port(cPtr, CInt(newValue))
		}
	}

	/// Gets the UDP port in the `Transports` object. 
	/// - Returns: the UDP port 
	public var udpPort: Int
	{
		get
		{
			return Int(linphone_transports_get_udp_port(cPtr))
		}
		set
		{
			linphone_transports_set_udp_port(cPtr, CInt(newValue))
		}
	}

	/// Gets the user data in the `Transports` object. 
	/// - Returns: the user data 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_transports_get_user_data(cPtr)
		}
		set
		{
			linphone_transports_set_user_data(cPtr, newValue)
		}
	}
}

/// Linphone tunnel object. 
public class Tunnel : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Tunnel {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Tunnel>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Tunnel(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	///Enum describing the tunnel modes. 
	public enum Mode:Int
	{
		/// The tunnel is disabled. 
		case Disable = 0
		/// The tunnel is enabled. 
		case Enable = 1
		/// The tunnel is enabled automatically if it is required. 
		case Auto = 2
	}

	/// Returns whether the tunnel is activated. 
	/// If mode is set to auto, this gives indication whether the automatic detection
	/// determined that tunnel was necessary or not. 
	/// 
	/// - Returns:  if tunnel is in use, true otherwise. 
	public var activated: Bool
	{
			return linphone_tunnel_get_activated(cPtr) != 0
	}

	/// Get the dual tunnel client mode. 
	/// - Returns:  if dual tunnel client mode is enabled, true otherwise 
	public var dualModeEnabled: Bool
	{
		get
		{
			return linphone_tunnel_dual_mode_enabled(cPtr) != 0
		}
		set
		{
			linphone_tunnel_enable_dual_mode(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the tunnel mode. 
	/// - Returns: The current LinphoneTunnelMode 
	public var mode: Tunnel.Mode
	{
		get
		{
			return Tunnel.Mode(rawValue: Int(linphone_tunnel_get_mode(cPtr).rawValue))!
		}
		set
		{
			linphone_tunnel_set_mode(cPtr, LinphoneTunnelMode(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get added servers. 
	/// - Returns: A list of `TunnelConfig` objects. LinphoneTunnelConfig  
	public var servers: [TunnelConfig]
	{
			var swiftList = [TunnelConfig]()
			var cList = linphone_tunnel_get_servers(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(TunnelConfig.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Check whether tunnel is set to transport SIP packets. 
	/// - Returns: A boolean value telling whether SIP packets shall pass through the
	/// tunnel 
	public var sipEnabled: Bool
	{
		get
		{
			return linphone_tunnel_sip_enabled(cPtr) != 0
		}
		set
		{
			linphone_tunnel_enable_sip(cPtr, newValue==true ? 1:0)
		}
	}
	///	Add a tunnel server configuration. 
	/// - Parameter tunnelConfig: `TunnelConfig` object 
	/// 
	public func addServer(tunnelConfig:TunnelConfig) 
	{
		linphone_tunnel_add_server(cPtr, tunnelConfig.cPtr)
	}
	///	Remove all tunnel server addresses previously entered with {@link
	///	Tunnel#addServer} 
	public func cleanServers() 
	{
		linphone_tunnel_clean_servers(cPtr)
	}
	///	Check whether the tunnel is connected. 
	/// - Returns: A boolean value telling if the tunnel is connected 
	public func connected() -> Bool
	{
		return linphone_tunnel_connected(cPtr) != 0
	}
	///	Force reconnection to the tunnel server. 
	/// This method is useful when the device switches from wifi to Edge/3G or vice
	/// versa. In most cases the tunnel client socket won't be notified promptly that
	/// its connection is now zombie, so it is recommended to call this method that
	/// will cause the lost connection to be closed and new connection to be issued. 
	public func reconnect() 
	{
		linphone_tunnel_reconnect(cPtr)
	}
	///	Remove a tunnel server configuration. 
	/// - Parameter tunnelConfig: `TunnelConfig` object 
	/// 
	public func removeServer(tunnelConfig:TunnelConfig) 
	{
		linphone_tunnel_remove_server(cPtr, tunnelConfig.cPtr)
	}
	///	Set an optional http proxy to go through when connecting to tunnel server. 
	/// - Parameter host: http proxy host 
	/// - Parameter port: http proxy port 
	/// - Parameter username: Optional http proxy username if the proxy request
	/// authentication. Currently only basic authentication is supported. Use nil if
	/// not needed. 
	/// - Parameter passwd: Optional http proxy password. Use nil if not needed. 
	/// 
	public func setHttpProxy(host:String, port:Int, username:String, passwd:String) 
	{
		linphone_tunnel_set_http_proxy(cPtr, host, CInt(port), username, passwd)
	}
	///	Set authentication info for the http proxy. 
	/// - Parameter username: User name 
	/// - Parameter passwd: Password 
	/// 
	public func setHttpProxyAuthInfo(username:String, passwd:String) 
	{
		linphone_tunnel_set_http_proxy_auth_info(cPtr, username, passwd)
	}
}

/// Tunnel settings. 
public class TunnelConfig : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> TunnelConfig {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<TunnelConfig>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = TunnelConfig(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Get the UDP packet round trip delay in ms for a tunnel configuration. 
	/// - Returns: The UDP packet round trip delay in ms. 
	public var delay: Int
	{
		get
		{
			return Int(linphone_tunnel_config_get_delay(cPtr))
		}
		set
		{
			linphone_tunnel_config_set_delay(cPtr, CInt(newValue))
		}
	}

	/// Get the IP address or hostname of the tunnel server. 
	/// - Returns: The tunnel server IP address or hostname 
	public var host: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_tunnel_config_get_host(cPtr))
		}
		set
		{
			linphone_tunnel_config_set_host(cPtr, newValue)
		}
	}

	/// Get the IP address or hostname of the second tunnel server when using dual
	/// tunnel client. 
	/// - Returns: The tunnel server IP address or hostname 
	public var host2: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_tunnel_config_get_host2(cPtr))
		}
		set
		{
			linphone_tunnel_config_set_host2(cPtr, newValue)
		}
	}

	/// Get the TLS port of the tunnel server. 
	/// - Returns: The TLS port of the tunnel server 
	public var port: Int
	{
		get
		{
			return Int(linphone_tunnel_config_get_port(cPtr))
		}
		set
		{
			linphone_tunnel_config_set_port(cPtr, CInt(newValue))
		}
	}

	/// Get the TLS port of the second tunnel server when using dual tunnel client. 
	/// - Returns: The TLS port of the tunnel server 
	public var port2: Int
	{
		get
		{
			return Int(linphone_tunnel_config_get_port2(cPtr))
		}
		set
		{
			linphone_tunnel_config_set_port2(cPtr, CInt(newValue))
		}
	}

	/// Get the remote port on the tunnel server side used to test UDP reachability. 
	/// This is used when the mode is set auto, to detect whether the tunnel has to be
	/// enabled or not. 
	/// 
	/// - Returns: The remote port on the tunnel server side used to test UDP
	/// reachability 
	public var remoteUdpMirrorPort: Int
	{
		get
		{
			return Int(linphone_tunnel_config_get_remote_udp_mirror_port(cPtr))
		}
		set
		{
			linphone_tunnel_config_set_remote_udp_mirror_port(cPtr, CInt(newValue))
		}
	}

	/// Retrieve user data from the tunnel config. 
	/// - Returns: the user data 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_tunnel_config_get_user_data(cPtr)
		}
		set
		{
			linphone_tunnel_config_set_user_data(cPtr, newValue)
		}
	}
}

/// The `Vcard` object. 
public class Vcard : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> Vcard {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Vcard>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Vcard(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Gets the eTag of the vCard. 
	/// - Returns: the eTag of the vCard in the CardDAV server, otherwise nil 
	public var etag: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_vcard_get_etag(cPtr))
		}
		set
		{
			linphone_vcard_set_etag(cPtr, newValue)
		}
	}

	/// Returns the family name in the N attribute of the vCard, or nil if it isn't set
	/// yet. 
	/// - Returns: the family name of the vCard, or nil 
	public var familyName: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_vcard_get_family_name(cPtr))
		}
		set
		{
			linphone_vcard_set_family_name(cPtr, newValue)
		}
	}

	/// Returns the FN attribute of the vCard, or nil if it isn't set yet. 
	/// - Returns: the display name of the vCard, or nil 
	public var fullName: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_vcard_get_full_name(cPtr))
		}
		set
		{
			linphone_vcard_set_full_name(cPtr, newValue)
		}
	}

	/// Returns the given name in the N attribute of the vCard, or nil if it isn't set
	/// yet. 
	/// - Returns: the given name of the vCard, or nil 
	public var givenName: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_vcard_get_given_name(cPtr))
		}
		set
		{
			linphone_vcard_set_given_name(cPtr, newValue)
		}
	}

	/// Gets the Organization of the vCard. 
	/// - Returns: the Organization of the vCard or nil 
	public var organization: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_vcard_get_organization(cPtr))
		}
		set
		{
			linphone_vcard_set_organization(cPtr, newValue)
		}
	}

	/// Returns the list of phone numbers (as string) in the vCard (all the TEL
	/// attributes) or nil. 
	/// - Returns: A list of const char * objects. const char *  
	public var phoneNumbers: [String]
	{
			var swiftList = [String]()
			var cList = linphone_vcard_get_phone_numbers(cPtr)
			while (cList != nil) {
				swiftList.append(String(cString: unsafeBitCast(cList!.pointee.data, to: UnsafePointer<CChar>.self)))
				cList = UnsafeMutablePointer<bctbx_list_t>(cList!.pointee.next)
			}
			return swiftList
	}

	/// Returns the list of SIP addresses (as LinphoneAddress) in the vCard (all the
	/// IMPP attributes that has an URI value starting by "sip:") or nil. 
	/// - Returns: A list of `Address` objects. LinphoneAddress  
	public var sipAddresses: [Address]
	{
			var swiftList = [Address]()
			var cList = linphone_vcard_get_sip_addresses(cPtr)
			while (cList != nil) {
				let data = unsafeBitCast(cList?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Address.getSwiftObject(cObject: data))
				cList = UnsafePointer<bctbx_list_t>(cList?.pointee.next)
			}
			return swiftList
	}

	/// Returns the skipFieldValidation property of the vcard. 
	/// - Returns: the skipFieldValidation property of the vcard 
	public var skipValidation: Bool
	{
		get
		{
			return linphone_vcard_get_skip_validation(cPtr) != 0
		}
		set
		{
			linphone_vcard_set_skip_validation(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the UID of the vCard. 
	/// - Returns: the UID of the vCard, otherwise nil 
	public var uid: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_vcard_get_uid(cPtr))
		}
		set
		{
			linphone_vcard_set_uid(cPtr, newValue)
		}
	}

	/// Gets the URL of the vCard. 
	/// - Returns: the URL of the vCard in the CardDAV server, otherwise nil 
	public var url: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_vcard_get_url(cPtr))
		}
		set
		{
			linphone_vcard_set_url(cPtr, newValue)
		}
	}
	///	Adds a phone number in the vCard, using the TEL property. 
	/// - Parameter phone: the phone number to add 
	/// 
	public func addPhoneNumber(phone:String) 
	{
		linphone_vcard_add_phone_number(cPtr, phone)
	}
	///	Adds a SIP address in the vCard, using the IMPP property. 
	/// - Parameter sipAddress: the SIP address to add 
	/// 
	public func addSipAddress(sipAddress:String) 
	{
		linphone_vcard_add_sip_address(cPtr, sipAddress)
	}
	///	Returns the vCard4 representation of the LinphoneVcard. 
	/// - Returns: a const char * that represents the vCard 
	public func asVcard4String() -> String
	{
		return charArrayToString(charPointer: linphone_vcard_as_vcard4_string(cPtr))
	}
	///	Clone a `Vcard`. 
	/// - Returns: a new `Vcard` object 
	public func clone() -> Vcard?
	{
		let cPointer = linphone_vcard_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		return Vcard.getSwiftObject(cObject: cPointer!)
	}
	///	Edits the preferred SIP address in the vCard (or the first one), using the IMPP
	///	property. 
	/// - Parameter sipAddress: the new SIP address 
	/// 
	public func editMainSipAddress(sipAddress:String) 
	{
		linphone_vcard_edit_main_sip_address(cPtr, sipAddress)
	}
	///	Generates a random unique id for the vCard. 
	/// If is required to be able to synchronize the vCard with a CardDAV server 
	/// 
	/// - Returns:  if operation is successful, otherwise true (for example if it
	/// already has an unique ID) 
	public func generateUniqueId() -> Bool
	{
		return linphone_vcard_generate_unique_id(cPtr) != 0
	}
	///	Removes a phone number in the vCard (if it exists), using the TEL property. 
	/// - Parameter phone: the phone number to remove 
	/// 
	public func removePhoneNumber(phone:String) 
	{
		linphone_vcard_remove_phone_number(cPtr, phone)
	}
	///	Removes a SIP address in the vCard (if it exists), using the IMPP property. 
	/// - Parameter sipAddress: the SIP address to remove 
	/// 
	public func removeSipAddress(sipAddress:String) 
	{
		linphone_vcard_remove_sip_address(cPtr, sipAddress)
	}
}

/// Structure describing policy regarding video streams establishments. 
public class VideoActivationPolicy : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> VideoActivationPolicy {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<VideoActivationPolicy>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = VideoActivationPolicy(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Gets the value for the automatically accept video policy. 
	/// - Returns: whether or not to automatically accept video requests is enabled 
	public var automaticallyAccept: Bool
	{
		get
		{
			return linphone_video_activation_policy_get_automatically_accept(cPtr) != 0
		}
		set
		{
			linphone_video_activation_policy_set_automatically_accept(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the value for the automatically initiate video policy. 
	/// - Returns: whether or not to automatically initiate video calls is enabled 
	public var automaticallyInitiate: Bool
	{
		get
		{
			return linphone_video_activation_policy_get_automatically_initiate(cPtr) != 0
		}
		set
		{
			linphone_video_activation_policy_set_automatically_initiate(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the user data in the `VideoActivationPolicy` object. 
	/// - Returns: the user data 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_video_activation_policy_get_user_data(cPtr)
		}
		set
		{
			linphone_video_activation_policy_set_user_data(cPtr, newValue)
		}
	}
}

/// The `VideoDefinition` object represents a video definition, eg. 
/// its width and its height. 
public class VideoDefinition : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> VideoDefinition {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<VideoDefinition>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = VideoDefinition(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Get the height of the video definition. 
	/// - Returns: The height of the video definition 
	public var height: UInt
	{
		get
		{
			return UInt(linphone_video_definition_get_height(cPtr))
		}
		set
		{
			linphone_video_definition_set_height(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Tells whether a `VideoDefinition` is undefined. 
	/// - Returns: A boolean value telling whether the `VideoDefinition` is undefined. 
	public var isUndefined: Bool
	{
			return linphone_video_definition_is_undefined(cPtr) != 0
	}

	/// Get the name of the video definition. 
	/// - Returns: The name of the video definition 
	public var name: String
	{
		get
		{
			return charArrayToString(charPointer: linphone_video_definition_get_name(cPtr))
		}
		set
		{
			linphone_video_definition_set_name(cPtr, newValue)
		}
	}

	/// Retrieve the user pointer associated with the video definition. 
	/// - Returns: The user pointer associated with the video definition. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_video_definition_get_user_data(cPtr)
		}
		set
		{
			linphone_video_definition_set_user_data(cPtr, newValue)
		}
	}

	/// Get the width of the video definition. 
	/// - Returns: The width of the video definition 
	public var width: UInt
	{
		get
		{
			return UInt(linphone_video_definition_get_width(cPtr))
		}
		set
		{
			linphone_video_definition_set_width(cPtr, CUnsignedInt(newValue))
		}
	}
	///	Clone a video definition. 
	/// - Returns: The new clone of the video definition 
	public func clone() -> VideoDefinition?
	{
		let cPointer = linphone_video_definition_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		return VideoDefinition.getSwiftObject(cObject: cPointer!)
	}
	///	Tells whether two `VideoDefinition` objects are equal (the widths and the
	///	heights are the same but can be switched). 
	/// - Parameter vdef2: `VideoDefinition` object 
	/// 
	/// 
	/// - Returns: A boolean value telling whether the two `VideoDefinition` objects
	/// are equal. 
	public func equals(vdef2:VideoDefinition) -> Bool
	{
		return linphone_video_definition_equals(cPtr, vdef2.cPtr) != 0
	}
	///	Set the width and the height of the video definition. 
	/// - Parameter width: The width of the video definition 
	/// - Parameter height: The height of the video definition 
	/// 
	public func setDefinition(width:UInt, height:UInt) 
	{
		linphone_video_definition_set_definition(cPtr, CUnsignedInt(width), CUnsignedInt(height))
	}
	///	Tells whether two `VideoDefinition` objects are strictly equal (the widths are
	///	the same and the heights are the same). 
	/// - Parameter vdef2: `VideoDefinition` object 
	/// 
	/// 
	/// - Returns: A boolean value telling whether the two `VideoDefinition` objects
	/// are strictly equal. 
	public func strictEquals(vdef2:VideoDefinition) -> Bool
	{
		return linphone_video_definition_strict_equals(cPtr, vdef2.cPtr) != 0
	}
}

/// The `XmlRpcRequest` object representing a XML-RPC request to be sent. 
public class XmlRpcRequest : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> XmlRpcRequest {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<XmlRpcRequest>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = XmlRpcRequest(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	public func getDelegate() -> XmlRpcRequestDelegate?
	{
		let cObject = linphone_xml_rpc_request_get_callbacks(cPtr)
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<XmlRpcRequestDelegate>.fromOpaque(result!).takeUnretainedValue()
			}
		return nil
	}
	public func addDelegate(delegate: XmlRpcRequestDelegate)
	{
		linphone_xml_rpc_request_add_callbacks(cPtr, delegate.cPtr)
	}
	public func removeDelegate(delegate: XmlRpcRequestDelegate)
	{
		linphone_xml_rpc_request_remove_callbacks(cPtr, delegate.cPtr)
	}

	/// Get the content of the XML-RPC request. 
	/// - Returns: The string representation of the content of the XML-RPC request. 
	public var content: String
	{
			return charArrayToString(charPointer: linphone_xml_rpc_request_get_content(cPtr))
	}

	/// Get the current LinphoneXmlRpcRequestCbs object associated with a
	/// LinphoneXmlRpcRequest. 
	/// - Returns: The current LinphoneXmlRpcRequestCbs object associated with the
	/// LinphoneXmlRpcRequest. 
	public var currentCallbacks: XmlRpcRequestDelegate?
	{
			let cObject = linphone_xml_rpc_request_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<XmlRpcRequestDelegate>.fromOpaque(result!).takeUnretainedValue()
				}
			return nil
	}

	/// Get the response to an XML-RPC request sent with {@link
	/// XmlRpcSession#sendRequest} and returning an integer response. 
	/// - Returns: The integer response to the XML-RPC request. 
	public var intResponse: Int
	{
			return Int(linphone_xml_rpc_request_get_int_response(cPtr))
	}

	/// Get the raw response to an XML-RPC request sent with {@link
	/// XmlRpcSession#sendRequest} and returning http body as string. 
	/// - Returns: The string response to the XML-RPC request. 
	public var rawResponse: String
	{
			return charArrayToString(charPointer: linphone_xml_rpc_request_get_raw_response(cPtr))
	}

	/// Get the status of the XML-RPC request. 
	/// - Returns: The status of the XML-RPC request. 
	public var status: XmlRpcStatus
	{
			return XmlRpcStatus(rawValue: Int(linphone_xml_rpc_request_get_status(cPtr).rawValue))!
	}

	/// Get the response to an XML-RPC request sent with {@link
	/// XmlRpcSession#sendRequest} and returning a string response. 
	/// - Returns: The string response to the XML-RPC request. 
	public var stringResponse: String
	{
			return charArrayToString(charPointer: linphone_xml_rpc_request_get_string_response(cPtr))
	}

	/// Retrieve the user pointer associated with the XML-RPC request. 
	/// - Returns: The user pointer associated with the XML-RPC request. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_xml_rpc_request_get_user_data(cPtr)
		}
		set
		{
			linphone_xml_rpc_request_set_user_data(cPtr, newValue)
		}
	}
	///	Add an integer argument to an XML-RPC request. 
	/// - Parameter value: The integer value of the added argument. 
	/// 
	public func addIntArg(value:Int) 
	{
		linphone_xml_rpc_request_add_int_arg(cPtr, CInt(value))
	}
	///	Add a string argument to an XML-RPC request. 
	/// - Parameter value: The string value of the added argument. 
	/// 
	public func addStringArg(value:String) 
	{
		linphone_xml_rpc_request_add_string_arg(cPtr, value)
	}
}

/// The `XmlRpcSession` object used to send XML-RPC requests and handle their
/// responses. 
public class XmlRpcSession : LinphoneObject
{
	static public func getSwiftObject(cObject:OpaquePointer) -> XmlRpcSession {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<XmlRpcSession>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = XmlRpcSession(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}


	/// Retrieve the user pointer associated with the XML-RPC session. 
	/// - Returns: The user pointer associated with the XML-RPC session. 
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_xml_rpc_session_get_user_data(cPtr)
		}
		set
		{
			linphone_xml_rpc_session_set_user_data(cPtr, newValue)
		}
	}
	///	Creates a `XmlRpcRequest` from a `XmlRpcSession`. 
	/// - Parameter returnType: the return type of the request as a
	/// LinphoneXmlRpcArgType 
	/// - Parameter method: the function name to call 
	/// 
	/// 
	/// - Returns: a `XmlRpcRequest` object 
	public func createRequest(returnType:XmlRpcArgType, method:String) throws -> XmlRpcRequest
	{
		let cPointer = linphone_xml_rpc_session_create_request(cPtr, LinphoneXmlRpcArgType(rawValue: CUnsignedInt(returnType.rawValue)), method)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null XmlRpcRequest value")
		}
		return XmlRpcRequest.getSwiftObject(cObject: cPointer!)
	}
	///	Stop and unref an XML rpc session. 
	/// Pending requests will be aborted. 
	public func release() 
	{
		linphone_xml_rpc_session_release(cPtr)
	}
	///	Send an XML-RPC request. 
	/// - Parameter request: The `XmlRpcRequest` to be sent. 
	/// 
	public func sendRequest(request:XmlRpcRequest) 
	{
		linphone_xml_rpc_session_send_request(cPtr, request.cPtr)
	}
}
