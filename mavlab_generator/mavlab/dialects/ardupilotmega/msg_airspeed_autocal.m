classdef msg_airspeed_autocal < MAVLinkMessage
	%MSG_AIRSPEED_AUTOCAL: MAVLink Message ID = 174
    %Description:
    %    Airspeed auto-calibration
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    vx(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    vx(single): GPS velocity north m/s
    %    vy(single): GPS velocity east m/s
    %    vz(single): GPS velocity down m/s
    %    diff_pressure(single): Differential pressure pascals
    %    EAS2TAS(single): Estimated to true airspeed ratio
    %    ratio(single): Airspeed ratio
    %    state_x(single): EKF state x
    %    state_y(single): EKF state y
    %    state_z(single): EKF state z
    %    Pax(single): EKF Pax
    %    Pby(single): EKF Pby
    %    Pcz(single): EKF Pcz
	
	properties(Constant)
		ID = 174
		LEN = 48
	end
	
	properties
        vx	%GPS velocity north m/s	|	(single)
        vy	%GPS velocity east m/s	|	(single)
        vz	%GPS velocity down m/s	|	(single)
        diff_pressure	%Differential pressure pascals	|	(single)
        EAS2TAS	%Estimated to true airspeed ratio	|	(single)
        ratio	%Airspeed ratio	|	(single)
        state_x	%EKF state x	|	(single)
        state_y	%EKF state y	|	(single)
        state_z	%EKF state z	|	(single)
        Pax	%EKF Pax	|	(single)
        Pby	%EKF Pby	|	(single)
        Pcz	%EKF Pcz	|	(single)
    end

    methods(Static)

        function send(out,vx,vy,vz,diff_pressure,EAS2TAS,ratio,state_x,state_y,state_z,Pax,Pby,Pcz,varargin)

            if nargin == 12 + 1
                msg = msg_airspeed_autocal(vx,vy,vz,diff_pressure,EAS2TAS,ratio,state_x,state_y,state_z,Pax,Pby,Pcz,varargin);
            elseif nargin == 2
                msg = msg_airspeed_autocal(vx);
            else
                MAVLink.throwCustomError('The number of function arguments is not valid');
                return;
            end

            packet = msg.pack();
            if ~isempty(packet)
                buffer = packet.encode();
                write(out,buffer);
            else
                MAVLink.throwCustomError('The packet could not be verified');
            end
        
        end

    end

    methods

        function obj = msg_airspeed_autocal(vx,vy,vz,diff_pressure,EAS2TAS,ratio,state_x,state_y,state_z,Pax,Pby,Pcz,varargin)
        %MSG_AIRSPEED_AUTOCAL: Create a new airspeed_autocal message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(vx,'MAVLinkPacket')
                    packet = vx;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('vx','MAVLinkPacket');
                end
            elseif nargin >= 12 && isempty(varargin{1})
                obj.vx = vx;
                obj.vy = vy;
                obj.vz = vz;
                obj.diff_pressure = diff_pressure;
                obj.EAS2TAS = EAS2TAS;
                obj.ratio = ratio;
                obj.state_x = state_x;
                obj.state_y = state_y;
                obj.state_z = state_z;
                obj.Pax = Pax;
                obj.Pby = Pby;
                obj.Pcz = Pcz;
            elseif nargin ~= 0
                MAVLink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLink message into a MAVLinkPacket
        %Description:
        %    Packs the fields of a message into a MAVLinkPacket which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = MAVLinkPacket(msg_airspeed_autocal.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_airspeed_autocal.ID;
                
                packet.payload.putSINGLE(obj.vx);
                packet.payload.putSINGLE(obj.vy);
                packet.payload.putSINGLE(obj.vz);
                packet.payload.putSINGLE(obj.diff_pressure);
                packet.payload.putSINGLE(obj.EAS2TAS);
                packet.payload.putSINGLE(obj.ratio);
                packet.payload.putSINGLE(obj.state_x);
                packet.payload.putSINGLE(obj.state_y);
                packet.payload.putSINGLE(obj.state_z);
                packet.payload.putSINGLE(obj.Pax);
                packet.payload.putSINGLE(obj.Pby);
                packet.payload.putSINGLE(obj.Pcz);

            else
                packet = [];
                MAVLink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a MAVLinkPayload into this MAVLink message
        %Description:
        %    Extracts the data from a MAVLinkPayload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(MAVLinkPayload): The payload to be unpacked into this MAVLink message

            payload.resetIndex();
            
            obj.vx = payload.getSINGLE();
            obj.vy = payload.getSINGLE();
            obj.vz = payload.getSINGLE();
            obj.diff_pressure = payload.getSINGLE();
            obj.EAS2TAS = payload.getSINGLE();
            obj.ratio = payload.getSINGLE();
            obj.state_x = payload.getSINGLE();
            obj.state_y = payload.getSINGLE();
            obj.state_z = payload.getSINGLE();
            obj.Pax = payload.getSINGLE();
            obj.Pby = payload.getSINGLE();
            obj.Pcz = payload.getSINGLE();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.vx,2) ~= 1
                result = 'vx';
            elseif size(obj.vy,2) ~= 1
                result = 'vy';
            elseif size(obj.vz,2) ~= 1
                result = 'vz';
            elseif size(obj.diff_pressure,2) ~= 1
                result = 'diff_pressure';
            elseif size(obj.EAS2TAS,2) ~= 1
                result = 'EAS2TAS';
            elseif size(obj.ratio,2) ~= 1
                result = 'ratio';
            elseif size(obj.state_x,2) ~= 1
                result = 'state_x';
            elseif size(obj.state_y,2) ~= 1
                result = 'state_y';
            elseif size(obj.state_z,2) ~= 1
                result = 'state_z';
            elseif size(obj.Pax,2) ~= 1
                result = 'Pax';
            elseif size(obj.Pby,2) ~= 1
                result = 'Pby';
            elseif size(obj.Pcz,2) ~= 1
                result = 'Pcz';

            else
                result = 0;
            end
        end

        function set.vx(obj,value)
            obj.vx = single(value);
        end
        
        function set.vy(obj,value)
            obj.vy = single(value);
        end
        
        function set.vz(obj,value)
            obj.vz = single(value);
        end
        
        function set.diff_pressure(obj,value)
            obj.diff_pressure = single(value);
        end
        
        function set.EAS2TAS(obj,value)
            obj.EAS2TAS = single(value);
        end
        
        function set.ratio(obj,value)
            obj.ratio = single(value);
        end
        
        function set.state_x(obj,value)
            obj.state_x = single(value);
        end
        
        function set.state_y(obj,value)
            obj.state_y = single(value);
        end
        
        function set.state_z(obj,value)
            obj.state_z = single(value);
        end
        
        function set.Pax(obj,value)
            obj.Pax = single(value);
        end
        
        function set.Pby(obj,value)
            obj.Pby = single(value);
        end
        
        function set.Pcz(obj,value)
            obj.Pcz = single(value);
        end
        
    end

end